class AddIconHeightToCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :categories, :icon_height, :integer, default: 25, null: false
  end
end
