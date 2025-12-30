class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params.expect(:id))
  end
end
