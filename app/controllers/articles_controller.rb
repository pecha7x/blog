class ArticlesController < ApplicationController
  def index
    @category = Category.friendly.find(params.expect(:category_id))
    @articles = @category.articles.published
  end
  def show
    @article = Article.friendly.find(params.expect(:id))
  end
end
