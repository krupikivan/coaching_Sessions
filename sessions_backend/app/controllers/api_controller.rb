require 'json'

class ApiController < ActionController::Base

    skip_forgery_protection
    
    include ResponseHelper
    include ExceptionHelper


    rescue_from BadParamsError, with: :dispatch_error_response

    def validate_required_params_present(args={})
        method = params[:action]
        errors = {}
        if !args[:params_needed].empty?
        args[:params_needed].each do |param|
            if !params.include? param
            param_name = ""
            param.split("_").each do |name|
                param_name = param_name.empty? ? name.capitalize : "#{param_name} #{name}"
            end
            errors[param] = "#{param_name} is required"
            end
        end
        end
        check_error_presents({errors: errors, method: method})
    end

    def check_error_presents(args={})
        if args[:errors].present?
            raise BadParamsError.new(args[:errors])
        end
    end

    def dispatch_error_response(e)
        render json: json_response_exception(e), status: e.status
    end
end