Rails.application.routes.draw do
  root 'axes#index'
  resources :kids
  resources :groups do
    resources :staffs
  end
  resources :heads do
    resources :staffs
  end
  resources :axes do
    resources :staffs
  end
  get '/staffs/:id', to: 'staffs#show', as: 'staff'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
