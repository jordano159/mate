Rails.application.routes.draw do
  resources :events
  resources :checks
  devise_for :staffs
  root 'application#home_page'
  resources :kids
  post 'kids/import' => 'kids#import'
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
  get 'staffs', to: 'application#admin_index'
end
