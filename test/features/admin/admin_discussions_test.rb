require 'test_helper'

class AdminDiscussionsTest < Capybara::Rails::TestCase
  def setup
    create(:user, username: 'Guest')
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  test 'admin sees the list of discussions and the list of comment responses' do
    discussion = create(:discussion, title: 'Visible in admin section')
    5.times { create(:discussion_comment, discussion: discussion) }
    visit admin_discussions_path
    assert_content page, 'Visible in admin section'
    assert_content page, '5'
  end

  test 'admin can click through to a discussion page from the admin discussion list' do
    discussion = create(:discussion, title: 'Visible in admin section', body: 'Too sexy for my shirt')
    visit admin_discussions_path
    click_link 'Visible in admin section'
    assert_content page, 'Too sexy for my shirt'
  end
end