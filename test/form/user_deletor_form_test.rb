# frozen_string_literal: true

require 'test_helper'

class UserDeletorFormTest < ActiveSupport::TestCase
  def before_setup
    super

    VCR.use_cassette('success_get_users') do
      UserUpdaterService.new(limit: 20).perform
      DailyRecordUpdaterService.new.perform
    end
  end

  test 'user not exist' do
    assert_raises(ActiveRecord::RecordNotFound) { UserDeletorForm.new(uuid: SecureRandom.uuid).perform }
  end

  test 'delete user' do
    user = User.where(gender: :male).first
    assert_difference(
      -> { User.count } => -1,
      -> { DailyRecord.first.male_count } => -1,
      -> { HourlyRecord.load.male_count } => -1,
      -> { HourlyRecord.load.female_count } => 0,
      -> { DailyRecord.first.female_count } => 0,
      -> { DailyRecord.first.female_avg_age.round } => 0,
      -> { DailyRecord.first.male_avg_age.round } => -1
    ) do
      UserDeletorForm.new(uuid: user.uuid).perform
    end
  end
end
