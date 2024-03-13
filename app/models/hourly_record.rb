# frozen_string_literal: true

##
# This class is a model to store data male_count and female_count in redis
# available attribute male_count and female_count
class HourlyRecord
  MALE_COUNT_KEY = 'male_count'
  FEMALE_COUNT_KEY = 'female_count'

  include ActiveModel::Model

  attr_accessor :male_count, :female_count

  ##
  # Rewrite the exisitng key value with the new value
  def save
    Rails.cache.write(MALE_COUNT_KEY, male_count.to_i, raw: true)
    Rails.cache.write(FEMALE_COUNT_KEY, female_count.to_i, raw: true)

    true
  end

  ##
  # Read the existing key value
  def self.load
    new(
      male_count: Rails.cache.read(MALE_COUNT_KEY, raw: true).to_i,
      female_count: Rails.cache.read(FEMALE_COUNT_KEY, raw: true).to_i
    )
  end

  ##
  # Increment the existing key value with the new value
  def increment
    Rails.cache.increment(MALE_COUNT_KEY, male_count.to_i)
    Rails.cache.increment(FEMALE_COUNT_KEY, female_count.to_i)

    true
  end

  ##
  # Reset the key value back to 0
  def self.reset
    Rails.cache.write(MALE_COUNT_KEY, 0, raw: true)
    Rails.cache.write(FEMALE_COUNT_KEY, 0, raw: true)
  end
end
