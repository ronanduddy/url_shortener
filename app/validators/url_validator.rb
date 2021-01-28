class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    invalidate(record, attribute) unless url?(value)
  end

  private

  def url?(value)
    url = URI.parse(value)

    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end

  def invalidate(record, attribute)
    record.errors.add(attribute, 'must be valid')
  end
end
