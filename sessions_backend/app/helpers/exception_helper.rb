module ExceptionHelper
    
    class CustomException < Exception
    end

    class BadParamsError < CustomException
        attr_reader :code, :status, :message
        def initialize(message)
            @code = "bad-params"
            @status = 400
            @message = message
            super(
              status: @status,
              message: message,
              code: code,
            )
        end
    end

    class ConflictError < CustomException
        attr_reader :code, :status, :message
        def initialize(message)
            @code = "conflict"
            @status = 409
            @message = message
            super(
              status: @status,
              message: message,
              code: code,
            )
        end
    end

end