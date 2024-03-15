# frozen_string_literal: true

##
# This class is used to extract the average age of the user seperated by genders
class AverageAgeCalculatorService
  ##
  # query the average age for both female and male using the aggregate AVG
  # @return [BigDecimal, BigDecimal] the first one is average age for male and the second one is female
  def perform
    [male_record.average_age, female_record.average_age]
  end

  private

  def male_record
    User.select(' COALESCE(AVG(age), 0) average_age').where(gender: :male)[0]
  end

  def female_record
    User.select(' COALESCE(AVG(age), 0) average_age').where(gender: :female)[0]
  end
end
