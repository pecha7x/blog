class Article < ApplicationRecord
  extend FriendlyId

  belongs_to :category

  has_rich_text :content

  validates :title, presence: true, length: { minimum: 3 }

  friendly_id :title, use: :slugged

  positioned on: [ :category, :status ]

  default_scope { order(:position) }

  enum :status, {
    draft: 0,
    published: 1,
    archived: 2
  }
end
