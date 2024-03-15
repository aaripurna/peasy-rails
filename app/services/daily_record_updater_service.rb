# frozen_string_literal: true

##
# This class is used to create a recap of daily record. It will be executed via cron job
class DailyRecordUpdaterService
  def perform
    ApplicationRecord.transaction do
      if daily_record.male_count_changed? || daily_record.female_count_changed?
        calculator = AverageAgeCalculatorService.new
        male_avg_age, female_avg_age = calculator.perform

        daily_record.male_avg_age = male_avg_age
        daily_record.female_avg_age = female_avg_age
      end

      daily_record.save
    end
  end

  private

  def daily_record
    @daily_record ||= begin
      hourly_record = HourlyRecord.load
      daily_record = DailyRecord.first_or_initialize

      daily_record.date = Time.zone.today
      daily_record.male_count = hourly_record.male_count
      daily_record.female_count = hourly_record.female_count

      daily_record
    end
  end
end
