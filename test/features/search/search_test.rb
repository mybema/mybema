require 'test_helper'

class Search < Capybara::Rails::TestCase
  test 'user can search for a discussion' do
    guest      = create(:user, username: 'Guest')
    category   = create(:discussion_category, name: 'Cool category')
    discussion = create(:discussion, discussion_category: category,
                                     user: guest, title: 'Good chat', body: 'This is very informative')
    Discussion.import
    Discussion.__elasticsearch__.refresh_index!
    visit root_path
    fill_in 'query', with: 'chat'
    click_button 'SEARCH'
    assert_content page, 'Good chat'
  end

  test 'search only returns visible discussions' do
    guest = create(:user, username: 'Guest')
    create(:discussion, user: guest, title: 'Good chat', body: 'Will show')
    create(:discussion, user: guest, hidden: true, title: 'Good chat', body: 'Will not show')
    Discussion.import
    Discussion.__elasticsearch__.refresh_index!
    visit root_path
    fill_in 'query', with: 'chat'
    click_button 'SEARCH'
    assert_content page, 'Will show'
    assert_content page, '1 search result'
    refute_content page, 'Will not show'
  end
end