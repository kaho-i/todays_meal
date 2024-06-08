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
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :restrants, only: [:index, :show] do
      resources :reservations, only: [:new, :create, :index, :show] do
        collection do
          post 'check', to: 'reservations#check'
        end
      end
    end
    get "search" => "searches#search"
  end
  # 店用
  # URL /shop/sign_in ...
  get '/shop', to: 'shop/homes#top'
  devise_for :restrants,skip: [:passwords], controllers: {
    registrations: "shop/registrations",
    sessions: 'shop/sessions'
  }, path: 'shop'
  namespace :shop do
    get '/mypage', to: 'restrants#show'
    get '/information/edit', to: 'restrants#edit'
    patch '/information', to: 'restrants#update'
    get '/confirm', to: 'restrants#confirm'
    patch '/close', to: 'restrants#close'
    resources :reservations, only: [:index, :show, :edit, :update]
    get 'search' => 'searches#search'
  end
  # 管理者用
  # URL /admin/sign_in ...
  get '/admin', to: 'admin/homes#top'
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :restrants, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    get 'search' => 'searches#search'
  end
end
