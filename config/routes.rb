Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "/users/:id", to: "users#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "groups#index"

  resources :groups do
    resources :plans do
      # member do
      #   post :new ,as: :back, action: :back
      # end
      collection do
        post :new ,as: :back, action: :back
        post :confirm
        post :save, as: :create, action: :create
      end
    end
    
  end
  # get "/groups/new", to: "groups#new"
  # post "/groups", to: "groups#create"

  # get "/groups/:id", to: "groups#show"
  #プラン表示
  # get "/groups/:id/plan", to: "plans#index"
  #プラン作成
  # resources :plans　
  # get "/groups/:id/plan/new", to: "plans#new"
end
