class Category < ApplicationRecord
  extend FriendlyId

  belongs_to :section
  has_many :articles

  has_one_attached :icon
  has_rich_text :description

  positioned on: :section

  default_scope { order(:position) }

  friendly_id :name, use: :slugged
end
