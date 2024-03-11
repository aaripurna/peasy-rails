module HttpRequest
  extend ActiveSupport::Concern
  class RequestError < StandardError; end

  OPEN_TIMEOUT = 1
  TIMEOUT = 5

  included do
    HTTPClient = Faraday.new(
      headers: {'Content-Type' => 'application/json'},
      request: {
        open_timeout: OPEN_TIMEOUT,
        timeout: TIMEOUT
      },
    )
  end
end