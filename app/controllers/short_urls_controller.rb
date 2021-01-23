require 'facades/short_urls_facade'

class ShortUrlsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_short_url, only: :create
  before_action :set_facade, only: [:index, :create]

  def index
  end

  def create
    # TODO: could pull into service object
    if @short_url.save
      redirect_to({ action: 'index' }, notice: 'Succesfully created the short URL')
    else
      @short_urls = current_user.short_urls
      render :index
    end
  end

  def show
    # TODO: could pull into service object
    @short_url = ShortUrl.find_by(slug: vanity_param)
    if @short_url
      @short_url.increment_views
      redirect_to @short_url.url
    else
      # TODO: could respond with 404?
      redirect_to(root_path, notice: 'Invalid short URL')
    end
  end

  private

  def set_short_url
    @short_url = ShortUrl.new(short_url_params)
    @short_url.user = current_user
  end

  def set_facade
    @facade = Facades::ShortUrlsFacade.new(current_user, @short_url)
  end

  def short_url_params
    params.require(:short_url).permit(:url)
  end

  def vanity_param
    params.require(:slug)
  end
end
