class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :position, null: false
      t.integer :section_id, null: false

      t.index [ :position, :section_id ], unique: true
    end
  end
end
