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
    patch 'monsters_transfer', to: 'species_groups#monsters_transfer'
    resources :monsters
    resources :untrained_monsters
    get 'monster', to: 'species_groups#trained_area'
    get 'untrained_monster', to: 'species_groups#untrained_area'
  end
  get 'monsters_search', to: 'monsters#search'
  get 'change_abilities_select', to: 'monsters#change_abilities_select'
  get 'change_abilities_select_untrained', to: 'untrained_monsters#change_abilities_select_untrained'
  get 'set_calculated_status', to: 'monsters#set_calculated_status'
  get 'set_calculated_status_untrained', to: 'untrained_monsters#set_calculated_status_untrained'
end
