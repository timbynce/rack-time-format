class DateFormatService

  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

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

  private

  def format_params(params)
    params = params.split(',')
    @formats, @invalid = params.partition { |param| FORMATS.key?(param) }
  end
end
