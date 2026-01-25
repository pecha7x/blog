class ArticlesController < ApplicationController
  def index
    @category = Category.friendly.find(params.expect(:category_id))
    @articles = @category.articles

    add_breadcrumb "Back to #{@category.name}", category_path(@category)
  end

  def show
    @article = Article.friendly.find(params.expect(:id))
    next_article = NextArticleService.call(article: @article)

    add_breadcrumb "Back to list", category_articles_path(@article.category)

    if next_article.present?
      add_breadcrumb "Next", category_article_path(next_article.category, next_article)
    end
  end
end
