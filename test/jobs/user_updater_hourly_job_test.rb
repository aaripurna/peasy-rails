# frozen_string_literal: true

require 'test_helper'
class UserUpdaterHourlyJobTest < ActiveJob::TestCase
  test 'test run update user' do
    VCR.use_cassette('success_get_users') do
      assert_difference('User.count', 20) do
        assert_performed_jobs 1, only: [UserUpdaterHourlyJob] do
          UserUpdaterHourlyJob.perform_later(20)
        end
      end
    end

    hourly = HourlyRecord.load
    assert_equal 9, hourly.female_count
    assert_equal 11, hourly.male_count
  end
end
