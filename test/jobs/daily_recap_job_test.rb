# frozen_string_literal: true

require "test_helper"

class DailyRecapJobTest < ActiveJob::TestCase
  test 'run the job' do
    DailyRecordUpdaterService.new.perform

    VCR.use_cassette('success_get_users') { UserUpdaterService.new(limit: 20).perform }

    assert_difference(
      -> { DailyRecord.first.female_count } => 9,
      -> { DailyRecord.first.male_count } => 11,
      -> { DailyRecord.first.female_avg_age.round(2) } => 45.56,
      -> { DailyRecord.first.male_avg_age.round(2) } => 41.64
    ) do
      assert_performed_jobs 1, only: [DailyRecapJob] do
        DailyRecapJob.perform_later
      end
    end
  end
end
