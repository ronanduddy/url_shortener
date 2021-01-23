class ShortUrl < ApplicationRecord
  belongs_to :user

  validates :url, :slug, presence: true
  validates :url, length: { in: 16..64 }
  validates :slug, length: { is: 8 }
  validates :views, numericality: { greater_than_or_equal_to: 0 }

  before_validation :generate_slug
  after_touch :increment_views

  private

  def generate_slug
    self.slug = SecureRandom.uuid[0..7] if self.slug.blank?
  end

  def increment_views
    self.views += 1
  end
end
