module Articles
  module Tree
    class AddChildService < ApplicationService
      attr_reader :article, :child

      def initialize(article:, child:)
        super
        @article = article
        @child = child
      end

      def call
        article.add_child(child)
      end
    end
  end
end
