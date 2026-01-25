class AddThreadPositionToArticles < ActiveRecord::Migration[8.1]
  def up
    remove_index :articles, column: [ :position, :category_id, :parent_id ]

    rename_column :articles, :position, :thread_position

    add_index :articles, [ :category_id, :parent_id, :thread_position ], unique: true
  end

  def down
    remove_index :articles, column: [ :category_id, :parent_id, :thread_position ]

    rename_column :articles, :thread_position, :position

    add_index :articles, [ :position, :category_id, :parent_id ], unique: true
  end
end
