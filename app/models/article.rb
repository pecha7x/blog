class Article < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true, length: { minimum: 10 }
end
