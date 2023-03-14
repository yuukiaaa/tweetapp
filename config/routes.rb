Rails.application.routes.draw do
  namespace :admin do
    get 'top/index'
  end
  # get "index" => "items#index"
  root "items#index"
  resources :items do
    member do
      get 'show_tweeter' # コントローラでtweeterアクションを使用可能にする、items/:id/show_tweeter
    end
  end
  resource :account, only: [:show, :new, :create, :edit, :update, :destroy] # 単数リソース、ログイン情報

  resource :session, only: [:create, :destroy] # 単数リソース、セッション情報

  resources :articles do
    patch "like", "unlike", on: :member
    get "voted", on: :collection
    resources :images, controller: "article_images"
  end

  # namespaceは名前空間、管理者用コントローラの作成
  namespace :admin do
    root "top#index" # admin_root_path or :admin_root
    resources :accounts do
      get "search", on: :collection
    end
    resources :articles do
      get "search", on: :collection
    end
  end

end
