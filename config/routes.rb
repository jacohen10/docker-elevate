Rails.application.routes.draw do
  get 'meals/call'
  get 'welcome/index'
  get 'welcome/new_restaurant'


  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'welcome#index'
  resources :restaurants do
    member do
      get 'admin'
    end
    resources :menus
    resources :categories do
      resources :menus
      resources :sides
    end
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
