class ArticlesController < ApplicationController
  def index
    category = Category.friendly.find(params.expect(:category_id))
    @articles = category.articles.roots.map do |root_article|
      {
        id: root_article.id,
        name: root_article.title,
        expanded: true,
        link: category_article_path(category, root_article),
        items: article_children_items(root_article, category)
      }
    end

    add_breadcrumb "Back to #{category.name}", category_path(category)
  end

  def show
    @article = Article.friendly.find(params.expect(:id))

    previous_article = Articles::Tree::Positioning::PreviousArticleService.call(article: @article)
    next_article = Articles::Tree::Positioning::NextArticleService.call(article: @article)

    if previous_article.present?
      add_breadcrumb "Back", category_article_path(previous_article.category, previous_article)
    else
      add_breadcrumb "Back", category_articles_path(@article.category)
    end

    if next_article.present?
      add_breadcrumb "Next", category_article_path(next_article.category, next_article)
    else
      add_breadcrumb "Back to list", category_articles_path(@article.category)
    end
  end

  private

  def article_children_items(article, category)
    article.children.map do |child|
      child_items = article_children_items(child, category)
      {
        id: child.id,
        name: child.title,
        expanded: true,
        link: category_article_path(category, child),
        items: child_items
      }
    end
  end
end
