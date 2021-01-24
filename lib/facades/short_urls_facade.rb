module Facades
  class ShortUrlsFacade
    def initialize(current_user, short_url=nil)
      @current_user = current_user
      @short_url = short_url
    end

    def build
      ShortUrl.new
    end

    def list      
      @list ||= @current_user&.short_urls || []
    end

    def errors?
      errors.present?
    end

    def errors
      @short_url&.errors
    end
  end
end
