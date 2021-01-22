class ShortUrl < ApplicationRecord
  belongs_to :user

  validates :url, :slug, presence: true
  validates :url, length: { in: 16..64 }
  validates :slug, length: { is: 8 }
end
