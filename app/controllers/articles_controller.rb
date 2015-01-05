class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id]).decorate
  end
end