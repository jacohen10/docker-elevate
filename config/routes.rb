Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/new_restaurant'

  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :restaurants do
    member do
      get 'admin'
    end
    resources :menus
    resources :sides
    resources :categories do
      resources :menus
      resources :sides
    end
    resources :open_times
    resources :meals, collection: { complete: :put }
  end

  resources :categories do
    resources :menus
    resources :sides
  end

  resources :customers do
    resources :meals
    resources :charges
  end

  resources :users do
    resources :customers
    resources :restaurants
  end

  resources :meal_confirmations, only: [] do
    member do
      get 'call'
      get 'acknowledge'
      get 'complete'
    end
  end
end
