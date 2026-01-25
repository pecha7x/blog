class Article < ApplicationRecord
  extend FriendlyId

  belongs_to :category

  has_rich_text :content
  has_closure_tree

  validates :title, presence: true, length: { minimum: 3 }

  friendly_id :title, use: :slugged

  positioned on: [ :category, :parent_id ]

  default_scope { order(:position) }
end
