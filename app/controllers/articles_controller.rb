class ArticlesController < ApplicationController
  def index
    category = Category.friendly.find(params.expect(:category_id))
    @articles = category.articles.roots.map do |root_article|
      {
        id: root_article.id,
        name: root_article.title,
        expanded: true,
        link: article_link(root_article, category),
        items: article_children_items(root_article, category)
      }
    end

    add_breadcrumb "Back to #{category.name}", category_path(category) if category.active?
  end

  def show
    @article = Article.friendly.find(params.expect(:id))
    @category = @article.category

    @article_parents = []
    article_parent_items(@article).each do |parent_item|
      @article_parents.append({
        title: parent_item.title,
        link: category_article_path(@category, parent_item)
      })
    end

    add_breadcrumbs
  end

  private

  def article_parent_items(article, parents = [])
    parent = article.parent
    return parents if parent.blank?

    parents.prepend(parent)
    article_parent_items(parent, parents)
  end

  def article_children_items(article, category)
    article.children.map do |child|
      child_items = article_children_items(child, category)
      {
        id: child.id,
        name: child.title,
        expanded: true,
        link: article_link(child, category),
        items: child_items
      }
    end
  end

  def article_link(article, category)
    return nil if article.node?

    category_article_path(category, article)
  end

  def add_breadcrumbs
    previous_article = Articles::Tree::Positioning::PreviousArticlesService.call(article: @article).normal.first
    next_article = Articles::Tree::Positioning::NextArticlesService.call(article: @article).normal.first

    if previous_article.present?
      add_breadcrumb "Prev", category_article_path(previous_article.category, previous_article)
    else
      add_breadcrumb "Back to list", category_articles_path(@article.category)
    end

    if next_article.present?
      add_breadcrumb "Next", category_article_path(next_article.category, next_article)
    else
      add_breadcrumb "Back to list", category_articles_path(@article.category) if previous_article.present?
    end
  end
end
