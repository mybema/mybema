require 'test_helper'

class Search < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    @guest = create(:user, username: 'Guest')
  end

  def refresh_search_indices
    Discussion.import force: true, refresh: true
    Article.import force: true, refresh: true
  end

  test 'user can search for a discussion' do
    category   = create(:discussion_category, name: 'Cool category')
    discussion = create(:discussion, discussion_category: category,
                                     user: @guest, title: 'Good chat', body: 'This is very informative')
    refresh_search_indices
    visit root_path
    within '.desktop-categories' do
      fill_in 'query', with: 'chat'
      click_button 'SEARCH'
    end
    assert_content page, 'Good chat'
  end

  test 'search only returns visible discussions' do
    create(:discussion, user: @guest, title: 'Good chat', body: 'Will show')
    create(:discussion, user: @guest, hidden: true, title: 'Good chat', body: 'Will not show')
    refresh_search_indices
    visit root_path
    within '.desktop-categories' do
      fill_in 'query', with: 'chat'
      click_button 'SEARCH'
    end
    assert_content page, 'Will show'
    assert_content page, '1 search result'
    refute_content page, 'Will not show'
  end

  test 'search returns relevant articles' do
    create(:article, title: 'White walls', body: 'and black doors')
    refresh_search_indices
    visit root_path
    within '.desktop-categories' do
      fill_in 'query', with: 'walls'
      click_button 'SEARCH'
    end
    assert_content page, 'White walls'
    assert_content page, '1 search result'
  end
end