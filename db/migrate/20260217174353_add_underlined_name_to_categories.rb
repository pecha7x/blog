class AddUnderlinedNameToCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :categories, :underlined_name, :boolean
  end
end
