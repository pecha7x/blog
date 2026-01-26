module Articles
  module Tree
    module Positioning
      module Thread
        class PreviousArticleService < ApplicationService
          attr_reader :article

          def initialize(article:)
            super
            @article = article
          end

          def call
            Article
              .where(category_id: article.category_id)
              .where(parent_id: article.parent_id)
              .where("thread_position < ?", article.thread_position)
              .where.not(id: article.id)
              .reorder(thread_position: :desc)
              .first
          end
        end
      end
    end
  end
end
