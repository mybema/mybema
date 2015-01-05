require 'test_helper'

class Search < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    @guest = create(:user, username: 'Guest')
  end

  test 'the community title displayed is the customizable one' do
    AppSettings.first.update_attributes(community_title: 'A custom title')
    visit root_path
    assert page.has_title? 'A custom title'
  end
end