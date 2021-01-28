class ShortUrlsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_form, except: :create
  before_action :set_facade

  def index    
  end

  def create
    @short_url_form = ShortUrlForm.new(short_url_params).as(current_user)
    if @short_url_form.save
      flash.now[:notice] = 'Succesfully created the short URL'
      render :index, status: :created
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    short_url = ShortUrl.find_by(slug: vanity_param)

    if short_url
      short_url.increment_views
      redirect_to short_url.url
    else
      flash.now[:notice] = 'Invalid short URL'
      render :index, status: :not_found
    end
  end

  private

  def set_form
    @short_url_form = ShortUrlForm.new
  end

  def set_facade
    @short_urls_facade = ShortUrlsFacade.new(current_user)
  end

  def short_url_params
    params.require(:short_url_form).permit(:url)
  end

  def vanity_param
    params.require(:slug)
  end
end
