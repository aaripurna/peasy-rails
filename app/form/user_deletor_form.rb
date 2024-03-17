# frozen_string_literal: true

##
# This form object is used to delete the user and update HourlyRecord, update DailyRecord
class UserDeletorForm < BaseForm
  attr_accessor :uuid

  after_perform :adjust_hourly_record
  after_perform :adjust_daily_record

  def execute
    user.delete
  end

  def adjust_hourly_record
    opts = user.male? ? { male_count: -1 } : { female_count: -1 }
    HourlyRecord.new(opts).increment
  end

  def adjust_daily_record
    DailyRecordUpdaterService.new.perform
  end

  def user
    @user ||= User.find(uuid)
  end
end
