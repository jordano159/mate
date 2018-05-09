Rails.application.routes.draw do
  root 'kids#index'
  resources :kids
  resources :groups
  resources :heads
  resources :axes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
