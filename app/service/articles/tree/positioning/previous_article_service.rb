module Articles
  module Tree
    module Positioning
      class PreviousArticlesService < ApplicationService
        attr_reader :article

        def initialize(article:)
          super
          @article = article
        end

        def call
          Article
            .where(category_id: article.category_id)
            .where("category_position < ?", article.category_position)
            .where.not(id: article.id)
            .reorder(category_position: :desc)
        end
      end
    end
  end
end
