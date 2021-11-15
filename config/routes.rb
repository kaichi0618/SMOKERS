Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :maps, only: [:index]

  resources :users, only: [:show, :edit, :update]
  get 'users/confirm' => 'users#confirm'
  patch 'users/unsubscribe' => 'users#unsubscribe'

  resources :shops do
    resource :shop_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end
