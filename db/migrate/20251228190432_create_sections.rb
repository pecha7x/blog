class CreateSections < ActiveRecord::Migration[8.1]
  def change
    create_table :sections do |t|
      t.string :name, null: false
      t.integer :position, null: false

      t.index :position, unique: true
    end
  end
end
