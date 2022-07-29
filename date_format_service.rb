class DateFormatService

  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  attr_reader :resp_body, :resp_status

  def initialize(formats)
    format_params(formats)
  end

  def time_with_format
    formats = @formats.map { |f| FORMATS[f] }.join('-')
    Time.now.strftime(formats)
  end

  def valid?
    @invalid.empty?
  end

  def invalid_formats
    "Unknown time format #{@invalid}"
  end

  def make_response
    if valid?
      @resp_status = 200
      @resp_body = time_with_format
    else
      @resp_status = 400
      @resp_body = invalid_formats
    end
  end

  private

  def format_params(params)
    params = params.split(',')
    @formats, @invalid = params.partition { |param| FORMATS.key?(param) }
  end
end
