class SearchController < ApplicationController
  def results
    @discussion_results = Discussion.search(params[:query]).records.where(hidden: false)
    @article_resutls = Article.search(params[:query]).records
  end
end