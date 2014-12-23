class SearchController < ApplicationController
  def results
    if params[:query].empty?
      articles = Article.search('*')
      discussions = Discussion.search('*')
    else
      articles = Article.search(params[:query])
      discussions = Discussion.search(params[:query])
    end

    @search_results = Array.new [articles, discussions].flatten
    @search_results.reject! { |result| result._source.hidden? }
  end
end