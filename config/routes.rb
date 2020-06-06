Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "/users/:id", to: "users#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "groups#index"

  resources :groups
  # get "/groups/new", to: "groups#new"
  # post "/groups", to: "groups#create"

  # get "/groups/:id", to: "groups#show"
  #プラン表示
  get "/groups/:id/plan", to: "plans#index"
  #プラン作成
  resources :plans
  get "/groups/:id/plan/new", to: "plans#new"
end
