module ShortUrlHelper
  def vanity_link(short_url)
    slug = short_url.slug
    link_to(vanity_url(slug), vanity_path(slug), method: :get)
  end
end
