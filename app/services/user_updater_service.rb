class UserUpdaterService
  def initialize(limit:)
    @limit = limit
  end

  def perform
    users_service = RandomUserService.new(limit: @limit)
    users = users_service.perform

    User.upsert_all(users.map(&:updatable_attributes))
  end
end