Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  root "posts#index"

  resources :posts do
    member do
      get :publish
      get :archive
    end
  end
  # resources :comments
  post '/comments/create', to: 'comments#create', as: 'comments'
  delete '/comments/:id', to: 'comments#destroy', as: 'comment'
end
