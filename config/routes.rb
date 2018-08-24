Rails.application.routes.draw do
  resources :posts, only: :create do
    resources :ranks, only: :create
  end
end
