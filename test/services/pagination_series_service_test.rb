# frozen_string_literal: true

require 'test_helper'

class PaginationSeriesServiceTest < ActiveSupport::TestCase
  test 'current_page: 1, total_page: 4' do
    assert_equal [1, 2, 3, 4],  PaginationSeriesService.new(current_page: 1, total_page: 4).perform
  end

  test 'current_page: 4, total_page: 4' do
    assert_equal [1, 2, 3, 4],  PaginationSeriesService.new(current_page: 4, total_page: 4).perform
  end

  test 'current_page: 3, total_page: 4' do
    assert_equal [1, 2, 3, 4],  PaginationSeriesService.new(current_page: 3, total_page: 4).perform
  end

  test 'current_page: 3, total_page: 10' do
    assert_equal [1, 2, 3, 4, 5, :gap], PaginationSeriesService.new(current_page: 3, total_page: 10).perform
  end

  test 'current_page: 8, total_page: 10' do
    assert_equal [:gap, 6, 7, 8, 9, 10], PaginationSeriesService.new(current_page: 8, total_page: 10).perform
  end

  test 'current_page: 10, total_page: 10' do
    assert_equal [:gap, 6, 7, 8, 9, 10], PaginationSeriesService.new(current_page: 10, total_page: 10).perform
  end

  test 'current_page: 4, total_page: 10' do
    assert_equal [:gap, 2, 3, 4, 5, 6, :gap], PaginationSeriesService.new(current_page: 4, total_page: 10).perform
  end
end
