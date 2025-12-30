class Article < ApplicationRecord
  extend FriendlyId

  belongs_to :category

  has_rich_text :content

  validates :title, presence: true, length: { minimum: 10 }

  friendly_id :title, use: :slugged
end
