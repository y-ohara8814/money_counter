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
        post :back ,as: :back, action: :back
        post :confirm
        post :save, as: :create, action: :create
      end
      member do
        post :edit, as: :edit_back, action: :edit_back
        post :edit_confirm, as: :edit_confirm, action: :edit_confirm
      end
      # resources :usages do
      #   post :create, as: :create, action: :create
      # end
    end
  end

  #利用金額登録
  get "/groups/:group_id/plans/:plan_id/new", to: "usages#new"
  post "/groups/:group_id/plans/usages/create", to: "usages#create", as: 'create_usage'

end
