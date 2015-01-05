require 'test_helper'

class DiscussionCreation < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
  end

  test 'the article page should have the HTML title set to its title' do
    article = create(:article, title: 'An article with a title')
    visit article_path(article)
    assert page.has_title? 'An article with a title'
  end
end