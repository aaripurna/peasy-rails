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
    find('#male-count-text').assert_text '11'
  end

  test 'delete user' do
    visit root_path(limit: 30)
    first('#user-table tbody tr a').click
    accept_alert 'Are you sure want to delete this?'
    sleep 1
    visit root_path
    assert_equal 19, all('#user-table tbody tr').size
  end
end
