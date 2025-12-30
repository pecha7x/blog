class AddCategoryIdToArticles < ActiveRecord::Migration[8.1]
  def change
    add_column :articles, :category_id, :integer, null: false
    add_index :articles, :category_id
  end
end
