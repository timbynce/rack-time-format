require_relative 'date_format_service'
require 'rack'

class App
  def call(env)
    @req = Rack::Request.new(env)
    return response(404, 'Page not found') unless time_req?
    
    format_date = DateFormatService.new(@req.params['format'])
    format_date.make_response
    response(format_date.resp_status, format_date.resp_body)
  end

  private

  def time_req?
    @req.get? && @req.path == '/time' && @req.params['format']
  end

  def response(status,body)
    [status, headers, ["#{body}\n"]]
  end

  def headers
    { "Context-Type" => "text-plain" }
  end

end
