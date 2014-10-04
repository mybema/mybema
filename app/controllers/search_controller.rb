class SearchController < ApplicationController
  def results
    articles = Article.search(params[:query])
    discussions = Discussion.search(params[:query])
    @search_results = Array.new [articles, discussions].flatten
    @search_results.reject! { |result| result._source.hidden? }
  end
end