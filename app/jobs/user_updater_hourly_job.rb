class UserUpdaterHourlyJob < ApplicationJob
  queue_as :default

  def perform(limit)
    service = UserUpdaterService.new(limit: limit)
    service.perform
  end
end
