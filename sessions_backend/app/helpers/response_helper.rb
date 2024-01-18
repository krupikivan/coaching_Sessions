module ResponseHelper
  def json_response_data(args)
    error = ''
    data = args[:data]
    success = args[:success].nil? ? true : args[:success]
    message = args[:message].nil? ? '' : args[:message]
    code = args[:code].nil? ? '' : args[:code]

    errors = args[:errors].nil? ? [] : args[:errors]

    if errors.is_a?(Array)
      errors.each do |_k, v|
        error = if error.empty?
                  "#{v}"
                else
                  "#{error}, #{v}"
                end
      end
    else
      error = errors
    end

    {
      'data' => data,
      'success' => success,
      'message' => message,
      'code' => code,
      'errors' => error
    }
  end

  def json_response_exception(exception)
    message = exception.message.nil? ? '' : exception.message
    code = exception.to_s.include?('code') ? exception.code : 'unknown-code'

    {
      'data' => nil,
      'success' => false,
      'message' => message,
      'code' => code,
      'errors' => ''
    }
  end
end
