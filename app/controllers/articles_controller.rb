class ArticlesController < ApplicationController
  def index
    @category = Category.friendly.find(params.expect(:category_id))
    @articles = @category.articles.published

    add_breadcrumb "Back to #{@category.name}", category_path(@category)
  end

  def show
    @article = Article.friendly.find(params.expect(:id))

    add_breadcrumb "Back", category_articles_path(@article.category)
  end
end
