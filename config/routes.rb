Rails.application.routes.draw do


  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :admin do
    get '/' => "homes#top"

    resources :genres,        only: [:index, :create, :edit, :update]

    resources :items,         only: [:index, :new, :create, :show, :edit, :update]

    resources :customers,     only: [:index, :show, :edit, :update]

    resources :orders,        only: [:show, :update]

    resources :order_details, only: [:update]

  end

  scope module: :public do
    get '/about' => "homes#about", as: "about"

    resources :items, only: [:index, :show]

  end

  root to: "public/homes#top"

  get 'search' => "items#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
