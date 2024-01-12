module ResponseHelper
    def json_response_data(args)
        error = ""
        data=args[:data]
        success = args[:success].nil? ? true : args[:success]
        message=args[:message].nil? ? "" : args[:message]
        code=args[:code].nil? ? "" : args[:code]
        
        errors=args[:errors].nil? ? [] : args[:errors]
    
        if errors.kind_of?(Array)
          errors.each do |k, v|
            if error.empty?
              error = "#{v}" 
            else
              error = "#{error}, #{v}" 
            end
          end
        else
          error = errors
        end
    
        post_data = {
            'data' => data,
            'success' => success,
            'message' => message,
            'code' => code,
            'errors' => error
        }
        return post_data
      end

      def json_response_exception(exception)
        message = exception.message.nil? ? "" : exception.message
        code = exception.to_s.include?("code") ? exception.code : "unknown-code"
        
        post_data = {
            'data' => nil,
            'success' => false,
            'message' => message,
            'code' => code,
            'errors' => ""
        }
        return post_data
      end
end