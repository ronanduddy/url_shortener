class ShortUrlsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def index
    # TODO: create short_url facade or set using before_action
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

  def show
    @short_url = ShortUrl.find_by(slug: vanity_param)
    if @short_url      
      @short_url.increment_views
      redirect_to @short_url.url
    else
      redirect_to(root_path, notice: 'Invalid short URL')
    end
  end

  private

  def short_url_params
    params.require(:short_url).permit(:url)
  end

  def vanity_param
    params.require(:slug)
  end
end
