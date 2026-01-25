class NextArticleService < ApplicationService
  attr_reader :article

  def initialize(article:)
    super
    @article = article
  end

  def call
    next_article = next_article_in_thread(article)
    return next_article if next_article.present?
  end

  private

  def next_article_in_thread(art)
    Article
      .where(parent_id: art.parent_id)
      .where(category_id: art.category_id)
      .where("position > ?", art.position)
      .where.not(id: art.id)
      .first
  end
end
