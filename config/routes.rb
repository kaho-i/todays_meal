Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  root to: 'public/homes#top'
  get "/about", to: "public/homes#about",as: 'about'
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    get '/mypage', to: 'users#mypage'
    patch '/users/:id/withdraw', to: 'users#withdraw'
    resources :users, only: [:index, :show, :edit, :update] do
      resources :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts do
      resources :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :shop, only: [:index, :show]
    resources :reservations, only: [:new, :create, :index, :show] do
      collection do
        post 'check', to: 'reservations#check'
      end
    end
  end
  # 店用
  # URL /shop/sign_in ...
  devise_for :shops,skip: [:passwords], controllers: {
    registrations: "shop/registrations",
    sessions: 'shop/sessions'
  }
  get '/shops', to: 'shop/shops#mypage'
  namespace :shops do
    get '/information/edit', to: 'shops#edit'
    patch '/information', to: 'shops#update'
    patch '/close', to: 'shops#close'
    resources :reservations, only: [:index, :show, :edit, :update]
  end
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  get '/admin', to: 'admin/homes#top'
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :shops, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
  end
end
