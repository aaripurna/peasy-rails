# frozen_string_literal: true

require 'test_helper'

class AverageAgeCalculatorServiceTest < ActiveSupport::TestCase
  test 'users average age' do
    [20, 30, 50, 60].each do |u|
      User.create(age: u, gender: :female)
    end

    [25, 50, 40, 50].each do |u|
      User.create(age: u, gender: :male)
    end

    service = AverageAgeCalculatorService.new

    average_male, average_female = service.perform
    assert_equal 40, average_female.round
    assert_equal 41, average_male.round
  end
end
