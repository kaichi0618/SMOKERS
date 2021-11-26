Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :maps, only: [:index]

  resources :users, only: [:show, :edit, :update] do
    member do
      get :favorites
    end
  end
  get 'users/confirm' => 'users#confirm'
  patch 'users/unsubscribe' => 'users#unsubscribe'

  resources :shops do
    resources :shop_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :notifications, only: :index
  resources :genres, only: [:index, :show]

end
