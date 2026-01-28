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

            children = Articles::Tree::GetChildrenService.call(article:)
            children.each_with_index do |child, i|
              article.update(category_position: position + i + 1)
            end
          end
        end

        private

        def replaceable_article
          @replaceable_article ||= begin
            if direction == :up
              Articles::Tree::Positioning::PreviousArticlesService.call(article:).first
            else
              Articles::Tree::Positioning::NextArticlesService.call(article:).first
            end
          end
        end
      end
    end
  end
end
