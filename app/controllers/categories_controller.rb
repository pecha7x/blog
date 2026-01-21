class CategoriesController < ApplicationController
  # add_breadcrumb "about", :about_path

  def show
    @category = Category.friendly.find(params.expect(:id))
    add_breadcrumb "View More", category_articles_path(@category)
  end
end
