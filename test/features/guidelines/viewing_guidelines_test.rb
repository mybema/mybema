require 'test_helper'

class ViewingGuidelinesTest < Capybara::Rails::TestCase
  test 'users can see the list of guidelines' do
    create(:user, username: 'Guest')
    create(:guideline, name: 'A simple order')
    visit new_discussion_path
    assert_content page, 'A simple order'
  end
end