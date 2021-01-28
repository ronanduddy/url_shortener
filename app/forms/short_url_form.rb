class ShortUrlForm
  include ActiveModel::Model

  attr_reader :form_owner
  attr_accessor :url

  validates :url, presence: true, length: { in: 16..128 }, url: true

  def save
    return unless valid?
    short_url.save!
  rescue ActiveRecord::RecordNotUnique => e
    errors.add(:slug, 'has already been taken')
    false
  end

  def as(user)
    @form_owner = user

    self
  end

  private

  def short_url
    ShortUrl.new(url: url, user: form_owner)
  end
end
