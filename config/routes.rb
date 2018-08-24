Rails.application.routes.draw do
  resources :posts, only: :create do
    resources :ranks, only: :create
  end

  scope controller: :stats do
    get 'top_by_rank'
    get 'ip_usage'
  end
end
