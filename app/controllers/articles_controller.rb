class ArticlesController < ApplicationController
  def show
    @article = Article.friendly.find(params.expect(:id))
  end
end
