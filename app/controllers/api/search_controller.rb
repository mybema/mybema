class Api::SearchController < ApplicationController
  def typeahead_article_prefetch
    render json: Article.all, root: false
  end

  def typeahead_discussion_prefetch
    render json: Discussion.visible, root: false
  end
end