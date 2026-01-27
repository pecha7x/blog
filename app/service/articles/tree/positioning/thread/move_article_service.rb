module Articles
  module Tree
    module Positioning
      module Thread
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
              article.update(thread_position: replaceable_article.thread_position)
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
end
