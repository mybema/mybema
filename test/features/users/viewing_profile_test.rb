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

  test 'user can view their profile from their profile editing page' do
    create(:user, email: 'jane@gmail.com', password: 'password', username: 'Jane Fonda')
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: 'jane@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    visit profile_path
    click_link 'View your profile'
    within('.profile-username') do
      page.must_have_content 'Jane Fonda'
    end
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
    within('.post-content') do
      click_link 'Jude'
    end
    assert_content page, 'I am not a bot'
  end

  test 'can navigate to user profile from a comment on a discussion page' do
    discussion = create(:discussion, user: @jude)
    another_user = create(:user, username: 'Jack', bio: 'I am cool')
    comment = create(:discussion_comment, id: 101, discussion: discussion, user: another_user)
    visit discussion_path(discussion.slug)
    page.first('div#discussion_comment_101').find('a').click
    assert_content page, 'I am cool'
  end

  test 'can navigate to user profile from the homepage' do
    discussion = create(:discussion, user: @jude)
    visit root_path
    within('.single-community-item--lens') do
      click_link 'Jude'
    end
    assert_content page, 'I am not a bot'
  end

  test 'can navigate to user profile from the discussions index page' do
    discussion = create(:discussion, user: @jude)
    visit discussions_path
    within('.single-community-item--lens') do
      click_link 'Jude'
    end
    assert_content page, 'I am not a bot'
  end
end