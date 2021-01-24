require 'facades/short_urls_facade'

class ShortUrlsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :build_short_url, only: :create
  before_action :find_short_url, only: :show
  before_action :set_facade, only: [:index, :create, :show]

  def index
  end

  def create
    if @short_url.save
      flash.now[:notice] = 'Succesfully created the short URL'
      render :index
    else
      @short_urls = current_user.short_urls
      render :index
    end
  end

  def show
    if @short_url
      @short_url.increment_views
      redirect_to @short_url.url
    else
      # TODO: could respond with 404?
      flash.now[:notice] = 'Invalid short URL'
      render :index
    end
  end

  private

  def find_short_url
    @short_url = ShortUrl.find_by(slug: vanity_param)
  end

  def build_short_url
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
