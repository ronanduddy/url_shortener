Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :short_urls, only: [:index, :create, :show]
  get '/:slug', to: 'short_urls#show_url', as: :vanity
end
