class ArticleDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  def is_fancy?
    excerpt? && hero_image?
  end

  def displayable_title
    unless is_fancy?
      article.title
    end
  end

  def markdown_body
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(body).html_safe
  end

  def article_title
    h.content_tag :div, class: 'kb-hero-title' do
      article.title
    end
  end

  def article_excerpt
    h.content_tag :div, class: 'kb-excerpt' do
      article.excerpt
    end
  end

  def sections_link
    h.content_tag :div, class: 'kb-hero--sections-link' do
      h.link_to 'Return to articles list', sections_path
    end
  end

  def article_wrap
    h.content_tag :div, class: 'kb-hero--content-wrap' do
      article_title << article_excerpt
    end
  end

  def article_hero_section
    if is_fancy?
      h.content_tag :div, class: 'kb-hero-wrapper' do
        h.content_tag :div, class: 'kb-hero-dark-wrapper' do
          sections_link << article_wrap
        end
      end
    end
  end
end