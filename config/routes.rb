Rails.application.routes.draw do

  devise_for :users, controllers: { :passwords => "passwords" }
  resources :users, only: [:show]
  resources :notifications, only: [:create, :destroy]

  root 'regions#index'
  get '/date_range' => 'regions#date_range'
  post '/current_position' => 'regions#current_position'
  post '/load_region' => 'regions#load_region'
  post '/load_region_from_address' => 'regions#load_region_from_address'
  post '/load_after_date_change' => 'regions#load_after_date_change'
  post '/update_surrounding' => 'regions#load_surrounding_regions'
  post 'twilio/send_text_message' => 'twilio#send_text_message'
end
