class ShortUrl < ApplicationRecord
  belongs_to :user

  validates :url, :slug, presence: true
  validates :url, length: { in: 16..64 }
  validates :slug, length: { is: 8 }

  before_validation :generate_slug

  def generate_slug
    self.slug = SecureRandom.uuid[0..7] if self.slug.blank?
  end
end
