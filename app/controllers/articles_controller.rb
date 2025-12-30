class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.friendly.find(params.expect(:id))
  end
end
