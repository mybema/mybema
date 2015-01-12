require 'test_helper'

class ViewingProfileTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    @guest = create(:user, username: 'Guest', bio: 'I am not a bot')
  end

  test 'can view a user profile' do
    create(:discussion, user: @guest, title: 'My discussion appears')
    visit user_profile_path('Guest')
    assert_content page, 'I am not a bot'
    assert_content page, 'My discussion appears'
  end

  test 'can navigate to user profile from the discussion on a discussion page' do
    discussion = create(:discussion, user: @guest)
    visit discussion_path(discussion.slug)
    click_link 'Guest'
    assert_content page, 'I am not a bot'
  end

  test 'can navigate to user profile from a comment on a discussion page' do
    discussion = create(:discussion, user: @guest)
    another_user = create(:user, username: 'Jack', bio: 'I am cool')
    comment = create(:discussion_comment, discussion: discussion, user: another_user)
    visit discussion_path(discussion.slug)
    click_link 'Jack'
    assert_content page, 'I am cool'
  end

  test 'can navigate to user profile from the homepage' do
    discussion = create(:discussion, user: @guest)
    visit root_path
    click_link 'Guest'
    assert_content page, 'I am not a bot'
  end

  test 'can navigate to user profile from the discussions index page' do
    discussion = create(:discussion, user: @guest)
    visit discussions_path
    click_link 'Guest'
    assert_content page, 'I am not a bot'
  end
end