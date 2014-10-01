require 'test_helper'

class AdminArticlesTest < Capybara::Rails::TestCase
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

  test 'admin sees the full list of articles' do
    create(:article, title: 'Short article')
    visit admin_articles_path
    assert_content page, 'Short article'
  end

  test 'admin can click through the the article from the listing page' do
    create(:article, title: 'Short article', body: 'I add no value')
    visit admin_articles_path
    click_link 'Short article'
    assert_content page, 'I add no value'
  end

  test 'admin can update an existing article' do
    article = create(:article, title: 'Old title', body: 'Old body')
    visit admin_articles_path
    click_link 'manage'
    fill_in 'article_title', with: 'New title'
    click_button 'update article'
    assert_content page, 'New title'
  end

  test 'admin can delete an existing article' do
    create(:article, title: 'Will be removed')
    visit admin_articles_path
    click_link 'manage'
    click_link 'delete article'
    assert_equal Article.count, 0
    refute_content page, 'Will be removed'
  end

  test 'admin can create a new article in via a section' do
    visit admin_sections_path
    click_link 'New section'
    fill_in 'section_title', with: 'SectionX'
    click_button 'add section'
    click_link 'New article'
    fill_in 'article_title', with: 'ArticleX'
    fill_in 'article_body', with: 'body'
    click_button 'add article'
    assert_equal Article.last.title, 'ArticleX'
    assert_content page, 'ArticleX'
  end

  test 'admin cannot create an article with an empty title and body' do
    create(:section, title: 'SectionY')
    visit admin_sections_path
    click_link 'SectionY'
    click_link 'New article'
    click_button 'add article'
    assert_content page, "Title can't be blank"
    assert_content page, "Body can't be blank"
  end
end