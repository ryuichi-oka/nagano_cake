Rails.application.routes.draw do

# 管理者側のルーティング
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  namespace :admin do
    get '/' => "homes#top"

    resources :genres,        only: [:index, :create, :edit, :update]

    resources :items,         only: [:index, :new, :create, :show, :edit, :update]

    resources :customers,     only: [:index, :show, :edit, :update]

    resources :orders,        only: [:show, :update]

    resources :order_details, only: [:update]

  end


# 会員側のルーティング
  scope module: :public do
    get '/about' => "homes#about", as: "about"

    resources :items, only: [:index, :show]

    resource :customers, only: [:show, :edit, :update]
    get '/customers/unsubscribe' => "customers#unsubscribe", as: "unsubscribe"
    patch '/customers/withdraw' => "customers#withdraw", as: "withdraw"

    resources :orders, only: [:new, :create, :index, :show]
    post '/orders/confirm' => "orders#confirm", as: "confirm"
    get '/orders/thanks' => "orders#thanks", as: "thanks"

    resources :addresses, only: [:new, :index, :create, :edit, :update, :destroy]

    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete '/cart_items/destroy_all' => "cart_items#destroy_all", as: "destroy_all"
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  root to: "public/homes#top"

  get 'search' => "items#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
