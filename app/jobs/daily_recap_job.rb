# frozen_string_literal: true

class DailyRecapJob < ApplicationJob # rubocop:disable Style/Documentation
  queue_as :default

  def perform
    DailyRecordUpdaterService.new.perform
  end
end
