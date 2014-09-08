class SearchController < ApplicationController
  def results
    @discussion_results = Discussion.search(params[:query]).records
  end
end