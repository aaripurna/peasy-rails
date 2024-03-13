# frozen_string_literal: true

##
# This class is responsible to fetch random user
class RandomUserService
  BASE_URL = 'https://randomuser.me/api'
  include HttpRequest

  ##
  # @params limit [Integer] the number of fetched users
  def initialize(limit:)
    @limit = limit
  end

  def perform
    response = HTTPClient.get(BASE_URL) do |req|
      req.params['results'] = @limit
    end

    raise RequestError, response.body unless response.status == 200

    parse_success_response(response)
  end

  private

  def parse_success_response(response)
    body = JSON.parse(response.body)
    body['results'].map { |user_json| parse_user(user_json) }
  end

  def parse_user(user_json)
    User.new(
      id: user_json.dig('login', 'uuid'),
      gender: user_json['gender'],
      name: user_json['name'],
      location: user_json['location'],
      age: user_json.dig('dob', 'age')
    )
  end
end
