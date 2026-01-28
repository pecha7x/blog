module Articles
  module Tree
    class GetChildrenService < ApplicationService
      attr_reader :article

      def initialize(article:)
        super
        @article = article
        @children_ids = []
      end

      def call
        populate_child_ids(article)

        Article.where(id: @children_ids).reorder(category_position: :asc)
      end

      private

      def populate_child_ids(article)
        article.children.each do |child_article|
          @children_ids << child_article.id

          populate_child_ids(child_article)
        end
      end
    end
  end
end
