class ShortUrlsFacade
  def initialize(current_user)
    @current_user = current_user
  end

  def list
    @list ||= @current_user&.short_urls || []
  end
end
