# frozen_string_literal: true

##
# This class is responsible to create pagination layout
class PaginationSeriesService
  include Enumerable

  def initialize(current_page:, total_page:)
    @current_page = current_page
    @total_page = total_page
    @layout = 4
    @pad = 2
    @first_page = 1
  end

  def perform
    series = inital_series

    series += [:gap] if series.last != @total_page

    series = [:gap] + series if series.first != @first_page

    series
  end

  def each(&block)
    perform.each(&block)
  end

  def inital_series
    if (@current_page + @pad) >= @total_page
      ([@total_page - @layout, @first_page].max..@total_page).to_a
    elsif (@current_page - @pad) <= @first_page
      (@first_page..[@first_page + @layout, @total_page].min).to_a
    else
      ([@current_page - @pad, @first_page].max..[@current_page + @pad, @total_page].min).to_a
    end
  end
end
