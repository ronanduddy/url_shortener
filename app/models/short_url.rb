class ShortUrl < ApplicationRecord
  # TODO: add index to slug
  belongs_to :user

  validates :url, :slug, presence: true
  validates :url, length: { in: 16..128 }
  validate  :valid_url
  validates :slug, length: { is: 7 }, uniqueness: true
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

  # TODO: extract into own validator
  def valid_url
    url = URI.parse(self.url) rescue false

    unless url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
      errors.add(:url, 'must be valid')
    end
  end
end
