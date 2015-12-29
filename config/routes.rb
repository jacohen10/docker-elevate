Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/new_restaurant'
  get '/restaurants/:id/admin', to: 'restaurants#admin'

  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'welcome#index'
  resources :restaurants do
    resources :menus
    resources :open_times
    resources :meals, collection: {complete: :put}
  end
  resources :customers do
    resources :meals
  end
  resources :users do
    resources :customers
    resources :restaurants
  end

end
