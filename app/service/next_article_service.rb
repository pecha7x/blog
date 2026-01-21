class NextArticleService < ApplicationService
  attr_reader :article

  delegate :category_id, :status, :position, :id, to: :article

  def initialize(article:)
    super
    @article = article
  end

  def call
    Article
      .where(category_id:, status:)
      .where.not(id: article.id)
      .where("position > ?", position)
      .last
  end
end
