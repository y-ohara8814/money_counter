Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "/users/:id", to: "users#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "groups#index"

  resources :groups do
    resources :plans do
      collection do
        post :new ,as: :back, action: :back
        post :confirm
        post :save, as: :create, action: :create
      end
      # resources :usages do
      #   post :create, as: :create, action: :create
      # end
    end
  end
  post "/groups/:group_id/plans/usages/create", to: "usages#create", as: 'create_usage'
end
