module Articles
  module Tree
    module Positioning
      class MoveArticleService < ApplicationService
        DIRECTIONS = %i[up down]

        attr_reader :article, :direction

        def initialize(article:, direction:)
          super
          raise ArgumentError, "Unsupported direction" unless DIRECTIONS.include?(direction)

          @article = article
          @direction = direction
        end

        def call
          if replaceable_article.present?
            article.update(category_position: replaceable_article.category_position)
          end
        end

        private

        def replaceable_article
          @replaceable_article ||= begin
            if direction == :up
              Articles::Tree::Positioning::PreviousArticleService.call(article:)
            else
              Articles::Tree::Positioning::NextArticleService.call(article:)
            end
          end
        end
      end
    end
  end
end
