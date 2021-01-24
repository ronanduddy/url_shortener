class ApplicationController < ActionController::Base
  def after_sign_in_path_for(user)
    short_urls_path
  end
end
