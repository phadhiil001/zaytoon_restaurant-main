Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'home#index'

  get '/about', to: 'static_pages#about'
  get '/contact', to: 'contact#new'
  post '/contact', to: 'contact#create'

  resources :categories, only: [:index, :show]
  resources :products, only: [:index, :show]
  resources :orders, only: [:new, :create, :show, :destroy] do
    collection do
      get 'past_orders'
      get 'current_order'
    end

    member do
      get 'invoice', to: 'orders#invoice'
      post 'create_checkout_session', to: 'orders#create_checkout_session'
      post 'checkout', to: 'orders#checkout'
      get 'success', to: 'orders#success'
      get 'cancel', to: 'orders#cancel'
      patch 'update_item/:item_id', to: 'orders#update_item', as: 'update_item'
      delete 'remove_item/:item_id', to: 'orders#remove_item', as: 'remove_item'
      post 'add_item', to: 'orders#add_item', as: 'add_item'
    end
  end

  get 'cart', to: 'orders#current_order', as: 'cart'

  get "up" => "rails/health#show", as: :rails_health_check
end

