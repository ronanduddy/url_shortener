class ShortUrlsController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: create short_url facade
    @short_urls = current_user.short_urls
    @short_url = ShortUrl.new
  end

  def create
    # TODO: create short_url facade
    @short_url = ShortUrl.new(short_url_params)
    @short_url.user = current_user

    if @short_url.save
      redirect_to({ action: 'index' }, notice: 'Succesfully created the short URL')
    else
      @short_urls = current_user.short_urls
      render :index
    end
  end

  private

  def short_url_params
    params.require(:short_url).permit(:url)
  end
end
