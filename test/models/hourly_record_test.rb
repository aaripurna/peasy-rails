# frozen_string_literal: true

require 'test_helper'

class HourlyRecordTest < ActiveSupport::TestCase
  def before_setup
    Rails.cache.clear
  end

  def after_teardown
    Rails.cache.clear
  end
  test 'no record saved' do
    record = HourlyRecord.load
    assert_equal 0, record.male_count
    assert_equal 0, record.female_count
  end

  test 'save record' do
    record = HourlyRecord.new(male_count: 10, female_count: 12)
    record.save

    r2 = HourlyRecord.load
    assert_equal r2.male_count, 10
    assert_equal r2.female_count, 12
  end

  test 'increment record' do
    record = HourlyRecord.new(male_count: 10, female_count: 12)
    record.save

    HourlyRecord.new(male_count: 4, female_count: 7).increment

    r2 = HourlyRecord.load
    assert_equal r2.male_count, 14
    assert_equal r2.female_count, 19
  end

  test 'increment negative' do
    record = HourlyRecord.new(male_count: 10, female_count: 12)
    record.save

    HourlyRecord.new(male_count: 0, female_count: -7).increment
    r2 = HourlyRecord.load
    assert_equal r2.male_count, 10
    assert_equal r2.female_count, 5
  end

  test 'reset existing data' do
    record = HourlyRecord.new(male_count: 10, female_count: 12)
    record.save

    r2 = HourlyRecord.load
    assert_equal r2.male_count, 10
    assert_equal r2.female_count, 12

    HourlyRecord.reset

    r3 = HourlyRecord.load
    assert_equal r3.male_count, 0
    assert_equal r3.female_count, 0
  end
end
