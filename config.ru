require_relative "middleware/bad_encoding_handler"
require_relative 'app'

use HandleBadEncodingMiddleware
run App.new
