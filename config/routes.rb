Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/sign_up', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :species_groups, shallow: true do
    resources :monsters
    resources :untrained_monsters
    get 'monster', to: 'species_groups#trained_area'
    get 'untrained_monster', to: 'species_groups#untrained_area'
  end
  get 'monsters_search', to: 'monsters#search'
end
