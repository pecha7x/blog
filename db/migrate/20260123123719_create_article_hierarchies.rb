class CreateArticleHierarchies < ActiveRecord::Migration[8.1]
  def change
    create_table :article_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :article_hierarchies, [ :ancestor_id, :descendant_id, :generations ],
      unique: true,
      name: "article_anc_desc_idx"

    add_index :article_hierarchies, [ :descendant_id ],
      name: "article_desc_idx"
  end
end
