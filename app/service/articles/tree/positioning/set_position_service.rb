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
        end
      end
    end
  end
end
