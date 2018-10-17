Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update] do
    #show user's all friends and inviters
    member do
      get :friend_list
      get :collection_list
      get :reply_list
      get :post_list
      get :draft_list
    end
  end

 
  resources :posts do
    # 在post下可Create and Destroy comments
    resources :comments, only: [:create, :update, :destroy]

    # 瀏覽所有users/posts/comments的最新動態
    collection do
      get :feeds
      get :last_replied
      get :most_viewed
      get :most_replies
    end
  
    member do
      # 加入/取消collect個別post
      post :collect
      post :uncollect
      post :draft
    end
  end

   # user可 建立/刪除 將其他user視為好友
  resources :friendships, only: [:create, :update, :destroy]

  # 一般使用者僅開放Read for category
  resources :categories, only: [:show] do
    member do
      get :last_replied
      get :most_viewed
      get :most_replies
    end
  end
  root "posts#index"

  # admin開放CRUD for category and update user.role
  namespace :admin do
    resources :users, only: [:index, :update]
    resources :categories
    root "categories#index"
  end



end
