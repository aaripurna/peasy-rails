require 'application_system_test_case'

class HomepageTest < ApplicationSystemTestCase
  def before_setup
    super

    VCR.use_cassette('success_get_users') do
      UserUpdaterService.new(limit: 20).perform
      DailyRecordUpdaterService.new.perform
    end
  end
  test 'user list' do
    visit root_path(limit: 30)
    assert_text 'NAME AGE GENDER CREATED AT ACTION'

    assert_equal 20, all('#user-table tbody tr').size
    daily_record = DailyRecord.first
    find('#male-count-text').assert_text daily_record.male_count
    find('#female-count-text').assert_text daily_record.female_count
    find('#male-avg-age-text').assert_text daily_record.male_avg_age.round(2)
    find('#female-avg-age-text').assert_text daily_record.female_avg_age.round(2)
  end

  test 'delete user' do
    visit root_path(limit: 30)
    first('#user-table tbody tr a').click
    accept_alert 'Are you sure want to delete this?'
    daily_record = DailyRecord.first
    find('#male-count-text').assert_text daily_record.male_count
    find('#female-count-text').assert_text daily_record.female_count
    find('#male-avg-age-text').assert_text daily_record.male_avg_age.round(2)
    find('#female-avg-age-text').assert_text daily_record.female_avg_age.round(2)

    sleep 1
    visit root_path
    assert_equal 19, all('#user-table tbody tr').size
    daily_record = DailyRecord.first
    find('#male-count-text').assert_text daily_record.male_count
    find('#female-count-text').assert_text daily_record.female_count
    find('#male-avg-age-text').assert_text daily_record.male_avg_age.round(2)
    find('#female-avg-age-text').assert_text daily_record.female_avg_age.round(2)
  end
end
