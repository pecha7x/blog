class RemoveStatusFromArticles < ActiveRecord::Migration[8.1]
  def up
    remove_index :articles, column: [ :position, :category_id, :status ]

    remove_column :articles, :status

    add_index :articles, [ :position, :category_id ], unique: true
  end

  def down
    remove_index :articles, column: [ :position, :category_id ]

    add_column :articles, :status, :integer, default: 0, null: false

    add_index :articles, [ :position, :category_id, :status ], unique: true
  end
end
