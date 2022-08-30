require_relative 'date_format_service'
require 'rack'

class App
  def call(env)
    @req = Rack::Request.new(env)
    return response(404, 'Page not found') unless time_req?
    
    format_date = DateFormatService.new(@req.params['format'])
    if format_date.valid?
      response(200, format_date.time_with_format)
    else
      response(400, format_date.invalid_formats)
    end
    @resp.finish

  end

  private

  def time_req?
    @req.get? && @req.path == '/time' && @req.params['format']
  end

  def response(status, body)
    @resp = Rack::Response.new(["#{body}\n"], status, headers)
  end

  def headers
    { "Context-Type" => "text-plain" }
  end

end
