# frozen_string_literal: true

Rails.application.routes.draw do
  resources :buses
  resources :events
  resources :checks
  devise_for :staffs
  root 'application#home_page'
  resources :kids do
    collection do
      post :import
    end
  end
  # post 'kids/import' => 'kids#import'
  resources :groups do
    resources :staffs do
      member do
        get :become
      end
    end
  end
  resources :heads do
    resources :staffs do
      member do
        get :become
      end
    end
  end
  resources :axes do
    resources :staffs do
      member do
        get :become
      end
    end
  end
  get '/staffs/:id', to: 'staffs#show', as: 'staff'
  get 'staffs', to: 'application#admin_index'
end
