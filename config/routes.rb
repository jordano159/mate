# frozen_string_literal: true

Rails.application.routes.draw do
  resources :contacts
  # get 'landing/index'
  resources :landing, only: [:index, :new, :create]
  resources :buses
  resources :events
  resources :checks
  resources :mifal_steps
  devise_for :staffs
  root 'application#home_page'
  resources :kids do
    collection do
      post :import
      get :stats
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
  resources :mifals do
    resources :staffs do
      member do
        get :become
      end
    end
  end
  get '/staffs/:id', to: 'staffs#show', as: 'staff'
  get 'staffs', to: 'application#admin_index'
  get '/prop', to: 'mifals#prop', as: 'prop'
  get '/reset_events', to: 'events#reset'
  get '/new_import_file', to: 'mifals#new_import_file', as: 'new_import_file'
  get '/toggle', to: 'kids#toggle', as: 'toggle'
  get '/recover/:id', to: 'kids#recover', as: 'recover'
  get "/cause" => 'mifal_steps#settings', as: 'cause'
  get "/leave_cause" => 'kids#show', as: 'leave_cause'
end
