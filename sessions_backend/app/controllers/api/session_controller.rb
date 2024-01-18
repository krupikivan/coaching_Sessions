class Api::SessionController < ApplicationController

  def get_sessions
    sessions = Session.all

    data = {
      data: sessions
    }
    render json: json_response_data(data)
  rescue StandardError => e
    render json: json_response_exception(e), status: 400
  end

  def get_clients
    response = Client.all

    data = {
      data: response
    }
    render json: json_response_data(data)
  rescue StandardError => e
    render json: json_response_exception(e), status: 400
  end

  def get_coaches
    response = Coach.all

    data = {
      data: response
    }
    render json: json_response_data(data)
  rescue StandardError => e
    render json: json_response_exception(e), status: 400
  end

  def create_session
    ActiveRecord::Base.transaction do
      raise ActionController::ParameterMissing, 'client_hash_id' unless params[:client_hash_id].present?
      raise ActionController::ParameterMissing, 'coach_hash_id' unless params[:coach_hash_id].present?
      raise ActionController::ParameterMissing, 'start' unless params[:start].present?
      raise ActionController::ParameterMissing, 'duration' unless params[:duration].present?

      client = Client.find(session_create_params[:client_hash_id])
      coach = Coach.find(session_create_params[:coach_hash_id])
      if client.nil?
        raise BadParamsError, 'Client not found'
      elsif coach.nil?
        raise BadParamsError, 'Coach not found'
      end

      raise ConflictError, 'Session overlap' if session_overlap

      result = Session.new(session_create_params)

      raise ConflictError, result.errors.full_messages unless result.save

      data = {
        data: session_overlap
      }

      render json: json_response_data(data), status: 201
    rescue CustomException => e
      render json: json_response_exception(e), status: e.status
      raise ActiveRecord::Rollback
    end
  end

  private

  def session_create_params
    params.permit(
      :start,
      :duration,
      :client_hash_id,
      :coach_hash_id
    )
  end

  def session_overlap
    coach = Coach.find(session_create_params[:coach_hash_id])
    start = DateTime.parse(session_create_params[:start])
    duration = session_create_params[:duration]
    coach.has_overlapping_session?(start, duration)
  end
end
