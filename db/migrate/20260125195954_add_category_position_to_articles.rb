class AddCategoryPositionToArticles < ActiveRecord::Migration[8.1]
  def change
    add_column :articles, :category_position, :integer

    Category.find_each do |category|
      category.articles.heal_category_position_column!
    end

    change_column_null(:articles, :category_position, false)

    add_index :articles, [ :category_id, :category_position ], unique: true
  end
end
