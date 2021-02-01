class ShortUrl < ApplicationRecord
  # TODO: add index to slug
  belongs_to :user
  has_many :url_accesses

  validates :url, presence: true, length: { in: 16..128 }, url: true
  validates :slug, presence: true, length: { is: 7 }, uniqueness: true
  validates :views, numericality: { greater_than_or_equal_to: 0 }

  before_validation :generate_slug

  default_scope { order(created_at: :desc) }

  def increment_views
    self.increment!(:views, touch: :updated_at)
  end

  private

  def generate_slug
    self.slug = SecureRandom.urlsafe_base64[0..6] if self.slug.blank?
  end
end
