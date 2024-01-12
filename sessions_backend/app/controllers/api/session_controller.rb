class Api::SessionController < ApiController

  before_action -> { validate_required_params_present(
    params_needed: [
      "start", 
      "duration",
      "client_hash_id",
      "coach_hash_id",
    ]) }, :only => [
    :create_session,
  ]

  def get_sessions
    begin
      Rails.logger.info "SessionController ::: get_sessions"
      sessions = Session.all

      data = {
          :data => sessions.map { |s| s.response },
      }
      render json: json_response_data(data)
    rescue => e
      render json: json_response_exception(e), status: 400
    end
  end

  def get_clients
    begin
      Rails.logger.info "SessionController ::: get_clients"
      response = Client.all

      data = {
          :data => response.map { |i| i.response },
      }
      render json: json_response_data(data)
    rescue => e
      render json: json_response_exception(e), status: 400
    end
  end

  def get_coaches
    begin
      Rails.logger.info "SessionController ::: get_coaches"
      response = Coach.all

      data = {
          :data => response.map { |i| i.response },
      }
      render json: json_response_data(data)
    rescue => e
      render json: json_response_exception(e), status: 400
    end
  end

  def create_session
    ActiveRecord::Base.transaction do
        begin
            Rails.logger.info "SessionController ::: create_session ::: #{params}"
            
            client = Client.find_by_hash(session_create_params[:client_hash_id]).presence || nil
            coach = Coach.find_by_hash(session_create_params[:coach_hash_id]).presence || nil
            if(client.nil?)
              raise BadParamsError.new("Client not found")
            elsif(coach.nil?)
              raise BadParamsError.new("Coach not found")
            end
            session_create_params[:start] = Time.parse(session_create_params[:start])
            session_create_params[:client_hash_id] = client.first.client_hash_id
            session_create_params[:coach_hash_id] = coach.first.coach_hash_id

            if(session_overlap)
              raise ConflictError.new("Session overlap")
            end

            result = Session.new(session_create_params)

            if(!result.save)
              raise ConflictError.new(result.errors.full_messages)
            end
            
            data = {
                :data => session_overlap
            }
            
            render json: json_response_data(data), status: 201
        rescue CustomException => e
            render json: json_response_exception(e), status: e.status
            raise ActiveRecord::Rollback
        end
    end
  end

  private
  def session_create_params
    params.permit(
        :start, 
        :duration,
        :client_hash_id,
        :coach_hash_id,
    )
  end

  def create_params
    params.permit(
        :name, 
    )
  end

  def session_overlap
    coach = Coach.find_by_hash(session_create_params[:coach_hash_id]).first
    start = DateTime.parse(session_create_params[:start])
    duration = session_create_params[:duration]
    return coach.has_overlapping_session?(start, duration)
  end

end
