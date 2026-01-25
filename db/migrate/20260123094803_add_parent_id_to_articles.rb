class AddParentIdToArticles < ActiveRecord::Migration[8.1]
  def change
    add_column :articles, :parent_id, :integer

    remove_index :articles, column: [ :position, :category_id ]

    add_index :articles, [ :position, :category_id, :parent_id ], unique: true
  end
end
