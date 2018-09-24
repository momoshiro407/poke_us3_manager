Rails.application.routes.draw do
  # get 'user/index'
  # resources :top_page
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'

  resources :users
  resources :species_groups
end
