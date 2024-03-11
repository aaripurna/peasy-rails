class HourlyRecord
  MALE_COUNT_KEY = 'male_count'
  FEMALE_COUNT_KEY = 'female_count'

  include ActiveModel::Model

  attr_accessor :male_count, :female_count

  def save
    Rails.cache.write(MALE_COUNT_KEY, male_count || 0)
    Rails.cache.write(FEMALE_COUNT_KEY, female_count || 0)

    true
  end

  def self.load
    new(
      male_count: Rails.cache.read(MALE_COUNT_KEY) || 0,
      female_count: Rails.cache.read(FEMALE_COUNT_KEY) || 0
    )
  end

  def increment
    Rails.cache.increment(MALE_COUNT_KEY, male_count || 0)
    Rails.cache.increment(FEMALE_COUNT_KEY, female_count || 0)

    true
  end

  def self.reset
    Rails.cache.write(MALE_COUNT_KEY, 0)
    Rails.cache.write(FEMALE_COUNT_KEY, 0)
  end
end