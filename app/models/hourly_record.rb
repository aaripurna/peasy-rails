class HourlyRecord
  MALE_COUNT_KEY = 'male_count'
  FEMALE_COUNT_KEY = 'female_count'

  include ActiveModel::Model

  attr_accessor :male_count, :female_count

  def save
    Rails.cache.write(MALE_COUNT_KEY, male_count.to_i, raw: true)
    Rails.cache.write(FEMALE_COUNT_KEY, female_count.to_i, raw: true)

    true
  end

  def self.load
    new(
      male_count: Rails.cache.read(MALE_COUNT_KEY, raw: true).to_i,
      female_count: Rails.cache.read(FEMALE_COUNT_KEY, raw: true).to_i
    )
  end

  def increment
    Rails.cache.increment(MALE_COUNT_KEY, male_count.to_i)
    Rails.cache.increment(FEMALE_COUNT_KEY, female_count.to_i)

    true
  end

  def self.reset
    Rails.cache.write(MALE_COUNT_KEY, 0, raw: true)
    Rails.cache.write(FEMALE_COUNT_KEY, 0, raw: true)
  end
end