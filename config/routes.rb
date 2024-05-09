Rails.application.routes.draw do
  # ゲストユーザーログイン時
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end
  # 利用者用
  # URL /users/sign_in ...
  root to: 'public/homes#top'
  get "/about", to: "public/homes#about",as: 'about'
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    get '/mypage', to: 'users#mypage', as: 'mypage'
    get 'users/:id/check', to: 'users#check', as: 'check'
    patch '/users/:id/withdraw', to: 'users#withdraw', as: 'withdraw'
    resources :users, only: [:index, :show, :edit, :update] do
      resources :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
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
  devise_for :shop,skip: [:passwords], controllers: {
    registrations: "shop/registrations",
    sessions: 'shop/sessions'
  }
  get '/shops/mypage', to: 'shop/shops#mypage'
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
