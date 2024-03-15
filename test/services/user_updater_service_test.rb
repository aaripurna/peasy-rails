# frozen_string_literal: true

require 'test_helper'

class UserUpdaterServiceTest < ActiveSupport::TestCase
  test 'user does not exists' do
    VCR.use_cassette('success_get_users') do
      assert_difference('User.count', 20) { UserUpdaterService.new(limit: 20).perform }
    end

    hourly = HourlyRecord.load
    assert_equal 9, hourly.female_count
    assert_equal 11, hourly.male_count
  end

  test 'uuid exists' do # rubocop:disable Metrics/BlockLength
    VCR.use_cassette('success_get_users') { UserUpdaterService.new(limit: 20).perform }
    location = {
      'city' => 'Foo',
      'state' => 'Bar',
      'street' => { 'name' => 'Andersons Bay Road', 'number' => 2988 },
      'country' => 'FooBAR',
      'postcode' => 82_243,
      'timezone' => { 'offset' => '+9:00', 'description' => 'Bangkok, Hanoi, Jakarta' },
      'coordinates' => { 'latitude' => '27.3832', 'longitude' => '23.4867' }
    }

    user = User.first
    new_user = User.new(
      uuid: user.uuid,
      gender: 'female',
      name: { 'last' => 'Bar', 'first' => 'Foo', 'title' => 'Ms' },
      age: 30,
      location:
    )

    mock = Minitest::Mock.new
    mock.expect :perform, [new_user]

    RandomUserService.stub :new, mock do
      assert_no_difference('User.count') { UserUpdaterService.new(limit: 20).perform }

      user = User.first
      assert_equal 30, user.age
      assert_equal({ 'last' => 'Bar', 'first' => 'Foo', 'title' => 'Ms' }, user.name)
      assert_equal 'female', user.gender
      assert_equal location, user.location
    end

    assert_mock mock

    hourly = HourlyRecord.load
    assert_equal 10, hourly.female_count
    assert_equal 10, hourly.male_count
  end
end
