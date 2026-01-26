class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params.expect(:id))
    add_breadcrumb "View More", category_articles_path(@category)
  end
end
