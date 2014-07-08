Rails.application.routes.draw do

  devise_for :users, controllers: { :passwords => "passwords" }
  resources :users, only: [:show]
  resources :notifications, only: [:create, :destroy]

  root 'regions#index'
  post '/current_position' => 'regions#current_position'
  post '/load_region' => 'regions#load_region'
  post '/load_region_from_address' => 'regions#load_region_from_address'
  post '/update_surrounding' => 'regions#load_surrounding_regions'
end
