module Articles
  module Tree
    module Positioning
      class SetPositionService < ApplicationService
        attr_reader :article, :position

        def initialize(article:, position:)
          super
          @article = article
          @position = position
        end

        def call
          article.update(category_position: position)

          children = Articles::Tree::GetChildrenService.call(article:)
          children.each_with_index do |child, i|
            article.update(category_position: position + i + 1)
          end
        end
      end
    end
  end
end
