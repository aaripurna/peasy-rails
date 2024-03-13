# frozen_string_literal: true

##
# This class is responsible to run the fetch random user service, Upsert the users, and update the hourly record
class UserUpdaterService
  ##
  # @param limit [Integer] the number of fetched users
  def initialize(limit:)
    @limit = limit
  end

  def perform
    users_service = RandomUserService.new(limit: @limit)
    users = users_service.perform

    ActiveRecord::Base.transaction do
      existing_users = User.where(uuid: users.pluck(:uuid))
      female_count, male_count = existing_users_count_by_gender(existing_users)

      User.upsert_all(users.map(&:updatable_attributes)) # rubocop:disable Rails/SkipsModelValidations
      increment_hourly_record(female_count, male_count)
    end
  end

  private

  def increment_hourly_record(female_count, male_count)
    female_users, male_users = separate_by_gender(users)

    HourlyRecord.new(
      female_count: female_users.length - female_count,
      male_count: male_users.length - male_count
    ).increment
  end

  def separate_by_gender(users)
    female_users = []
    male_users = []

    users.each do |user|
      if user.female?
        female_users << user
      else
        male_users << user
      end
    end

    [female_users, male_users]
  end

  def existing_users_count_by_gender(existing_users)
    female_count = 0
    male_count = 0

    existing_users.each do |user|
      if user.female?
        female_count += 1
      else
        male_count += 1
      end
    end

    [female_count, male_count]
  end
end
