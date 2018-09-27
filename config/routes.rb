Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to:'static_pages#help'
  get '/about', to:'static_pages#about'
  get '/sign_up', to:'users#new'

  resources :users
  resources :species_groups
end
