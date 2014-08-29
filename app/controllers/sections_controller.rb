class SectionsController < ApplicationController
  def index
    @sections = Section.with_articles
  end
end