Rails.application.routes.draw do
  resources :fan_arts
  resources :followups
  resources :posts
  resources :properties
  #resources :stances
  resources :purposes
  resources :move_effects
  resources :inputs
  resources :characters
  resources :moves
  devise_for :users
  resources :profiles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :stances do
    collection do
      post :restore_moves
      post 'stances/:id' => 'stances#restore_moves'
    end
  end

  root to: 'characters#index'
end
