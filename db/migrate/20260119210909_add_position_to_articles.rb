class AddPositionToArticles < ActiveRecord::Migration[8.1]
  def change
    ActiveRecord::Base.connection.execute("delete from articles;")

    add_column :articles, :position, :integer, null: false
    add_column :articles, :status, :integer, default: 0, null: false

    add_index :articles, [ :position, :category_id, :status ], unique: true
  end
end
