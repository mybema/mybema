require 'test_helper'

class DiscussionViewingTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    @guest = create(:user, username: 'Guest')
  end

  test 'the discussion page should have the HTML title set to its title' do
    discussion = create(:discussion, title: 'A discussion with a title')
    visit discussion_path(discussion.slug)
    assert page.has_title? 'A discussion with a title'
  end
end