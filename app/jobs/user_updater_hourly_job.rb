# frozen_string_literal: true

##
# This job class is resposible to update the user data dan the HourlyRecord.
# This class will be called from sidekiq cron
class UserUpdaterHourlyJob < ApplicationJob
  queue_as :default

  def perform(limit)
    service = UserUpdaterService.new(limit:)
    service.perform
  end
end
