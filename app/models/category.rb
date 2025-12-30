class Category < ApplicationRecord
  extend FriendlyId

  belongs_to :section
  has_many :articles

  positioned on: :section

  default_scope { order(:position) }

  friendly_id :name, use: :slugged
end
