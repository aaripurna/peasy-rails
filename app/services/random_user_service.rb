# require_relative "concerns/http_request"

class RandomUserService
  BASE_URL = 'https://randomuser.me/api'
  include HttpRequest

  def initialize(limit:)
    @limit = limit
  end

  def perform
    response = HTTPClient.get(BASE_URL) do |req|
      req.params["results"] = @limit
    end

    if response.status == 200
      parse_success_response(response)
    else
      raise RequestError, response.body
    end
  end

  private

  def parse_success_response(response)
    body = JSON.parse(response.body)
    body["results"]
  end
end