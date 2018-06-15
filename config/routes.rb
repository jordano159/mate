Rails.application.routes.draw do
  resources :checks
  devise_for :staffs
  root 'application#home_page'
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
end
