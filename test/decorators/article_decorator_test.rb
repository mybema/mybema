require 'test_helper'

class ArticleDecoratorTest < ActiveSupport::TestCase
  test '#is_fancy?' do
    article_decorator = ArticleDecorator.new(Article.new)
    assert_equal false, article_decorator.is_fancy?

    article_decorator = ArticleDecorator.new(Article.new(excerpt: 'excerpt'))
    assert_equal false, article_decorator.is_fancy?

    article_decorator = ArticleDecorator.new(Article.new(excerpt: 'excerpt',
                        hero_image: File.open(Rails.root.join("test/fixtures/image.png"))))
    assert_equal true, article_decorator.is_fancy?
  end

  test '#displayable_title' do
    article = ArticleDecorator.new(Article.new(title: 'title'))
    assert_equal 'title', article.displayable_title

    article = ArticleDecorator.new(Article.new(excerpt: 'excerpt', title: 'title',
              hero_image: File.open(Rails.root.join("test/fixtures/image.png"))))
    assert_equal nil, article.displayable_title
  end
end