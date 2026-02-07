class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params.expect(:id))

    if @category.node?
      redirect_to category_articles_path(@category)
    elsif @category.pending?
      redirect_to "/coming-soon"
    else
      add_breadcrumb "View More", category_articles_path(@category)
    end
  end
end
