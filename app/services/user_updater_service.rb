class UserUpdaterService
  def initialize(limit:)
    @limit = limit
  end

  def perform
    users_service = RandomUserService.new(limit: @limit)
    users = users_service.perform

    ActiveRecord::Base.transaction do
      female_count, male_count = existing_users_count_by_gender(users.pluck(:uuid))

      User.upsert_all(users.map(&:updatable_attributes))
      female_users, male_users = separate_by_gender(users)

      HourlyRecord.new(
        female_count: female_users.length - female_count,
        male_count: male_users.length - male_count
      ).increment
    end
  end

  private

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

  def existing_users_count_by_gender(uuids)
    existing_users = User.where(uuid: uuids)
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