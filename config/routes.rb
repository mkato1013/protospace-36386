Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"    #なぜgetとかpostとか消したのか？
  resources :prototypes
  resources :prototypes do
    resources :comments, only: :create   #[:create]で１個でも[]はつけるべきか？
  end
  resources :users, only: :show

end
