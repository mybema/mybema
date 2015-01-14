require 'test_helper'

class ViewingProfileTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
    @jude = create(:user, username: 'Jude', bio: 'I am not a bot')
  end

  test 'can view a user profile' do
    create(:discussion, user: @jude, title: 'My discussion appears')
    visit user_profile_path('Jude')
    assert_content page, 'I am not a bot'
    assert_content page, 'Discussions started'
    assert_content page, 'My discussion appears'
  end

  test 'can view the responses from a user on their profile' do
    create(:discussion_comment, user: @jude, body: 'My comment appears')
    visit user_profile_path('Jude')
    assert_content page, 'Responses posted'
    assert_content page, 'My comment appears'
  end

  test 'cannot see the comments section in a profile if a user has no comments' do
    visit user_profile_path('Jude')
    assert_content page, 'I am not a bot'
    refute_content page, 'Responses posted'
  end

  test 'can navigate to user profile from the discussion on a discussion page' do
    discussion = create(:discussion, user: @jude)
    visit discussion_path(discussion.slug)
    click_link 'Jude'
    assert_content page, 'I am not a bot'
  end

  test 'can navigate to user profile from a comment on a discussion page' do
    discussion = create(:discussion, user: @jude)
    another_user = create(:user, username: 'Jack', bio: 'I am cool')
    comment = create(:discussion_comment, discussion: discussion, user: another_user)
    visit discussion_path(discussion.slug)
    click_link 'Jack'
    assert_content page, 'I am cool'
  end

  test 'can navigate to user profile from the homepage' do
    discussion = create(:discussion, user: @jude)
    visit root_path
    click_link 'Jude'
    assert_content page, 'I am not a bot'
  end

  test 'can navigate to user profile from the discussions index page' do
    discussion = create(:discussion, user: @jude)
    visit discussions_path
    click_link 'Jude'
    assert_content page, 'I am not a bot'
  end
end