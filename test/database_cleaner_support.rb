# frozen_string_literal: true

module DatabaseCleanerSupport
  def before_setup
    super
    DatabaseCleaner.start
  end

  def after_teardown
    Rails.cache.clear
    DatabaseCleaner.clean
    super
  end
end
