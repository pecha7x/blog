class Section < ApplicationRecord
  has_many :categories

  positioned

  default_scope { order(:position) }
end
