Rails.application.routes.draw do


 # 管理者用 URL /admin/sign_in...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    root to: 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders, only: [:show,:update]
    resources :order_details, only: [:update]
  end


 # 顧客用 URL /customers/sign_in...sign_up...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  namespace :public do
    root to: "homes#top"
    get "home/about" => "homes#about", as: 'about'

    resources :items, only: [:index,:show]
    resources :addresses, only:[:index,:create,:edit,:update,:destroy]
    resources :orders, only: [:new,:complete,:index,:show]

    delete "cart_items/destroy_all" => 'cart_items#destroy_all', as: "destroy_all"
    resources :cart_items, only:[:index,:create,:update,:destroy]

    get "customers/mypage" => 'customers#show', as: "mypage"
    get "customers/followings" => "customers#followings", as: "followings"
    patch "customers/withdrawal" => "customers#withdrawal", as: "withdrawal"
    resources :customers, only:[:edit,:update]
  end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
