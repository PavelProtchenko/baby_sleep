Rails.application.routes.draw do
  require 'sidekiq/web'

  constraints subdomain: 'admin' do
    if Rails.env == 'production'
      Sidekiq::Web.use Rack::Auth::Basic do |username, password|
        username == Rails.application.credentials.dig(:sidekiq, :user) &&
        password == Rails.application.credentials.dig(:sidekiq, :password)
      end
      mount Sidekiq::Web => 'sidekiq'
    end
    get '/', to: 'admin/users#index'
    devise_for :users, path: '', skip: [:registrations]
    devise_scope :admin do
      post '/', to: 'devise/registrations#create', as: :admin_registration
      get 'settings', to: 'devise/registrations#edit', as: :edit_admin_registration
      put '/', to: 'devise/registrations#update'
    end

    scope module: :admin, as: :admin do
      resources :users
      resources :sounds do
        get :deleted_sounds, on: :collection
        put :deleted_status, on: :member
        put :regenerated_status, on: :member
      end
      resources :categories do
        put :update_position, on: :member
        put :deleted_status, on: :member
        put :regenerated_status, on: :member
      end
      resources :mixes
      resources :posts do
        put :publish_status, on: :member
      end
      resources :pictures, only: [:create, :destroy]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :categories
      resources :posts
      resources :verification_receipts, only: [:create]
    end
  end
end
