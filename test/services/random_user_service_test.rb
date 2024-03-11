require "test_helper"

class RandomUserServiceTest < ActiveSupport::TestCase
  test "test get users" do
    VCR.use_cassette("success_get_users") do
      service = RandomUserService.new(limit: 20)
      result = service.perform
      assert_equal result.size, 20
    end
  end
end