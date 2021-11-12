Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  root to: 'homes#top'
  resources users, only: [:show, :edit, :update]
  patch 'unsubscribe' => 'users#unsubscribe'
  get 'confirm' => 'users#confirm'
  resources shops do
    resources :shop_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
