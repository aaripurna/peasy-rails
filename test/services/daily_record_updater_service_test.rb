# frozen_string_literal: true

require 'test_helper'

class DailyRecordUpdaterServiceTest < ActiveSupport::TestCase
  test 'update the record no user data availabe' do
    service = DailyRecordUpdaterService.new
    service.perform
    daily_record = DailyRecord.first
    assert_equal Time.zone.today, daily_record.date
    assert_equal 0, daily_record.male_count
    assert_equal 0, daily_record.female_count
    assert_equal 0, daily_record.male_avg_age
    assert_equal 0, daily_record.female_avg_age
  end

  test 'the user updated' do
    DailyRecordUpdaterService.new.perform

    VCR.use_cassette('success_get_users') do
      assert_difference(-> { DailyRecord.first.male_count } => 11,
                        -> { DailyRecord.first.female_count } => 9,
                        -> { DailyRecord.first.male_avg_age.round } => 42,
                        -> { DailyRecord.first.female_avg_age.round } => 46) do
        UserUpdaterService.new(limit: 20).perform
        s = DailyRecordUpdaterService.new
        s.perform
      end
    end
  end

  test 'the user count not changed' do
    VCR.use_cassette('success_get_users') do
      UserUpdaterService.new(limit: 20).perform
      DailyRecordUpdaterService.new.perform
    end

    mock = Minitest::Mock.new
    def mock.perform
      raise 'Should not be called'
    end

    AverageAgeCalculatorService.stub :new, mock do
      assert_nothing_raised do
        s = DailyRecordUpdaterService.new
        s.perform
      end
    end

    assert_mock mock
  end
end
