Rails.application.routes.draw do
  get 'user/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :top_page
  resources :users
  resources :species_groups
end
