Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "/users/:id", to: "users#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "groups#index"

  get "/groups/new", to: "groups#new"
  post "/groups/new", to: "groups#create"
end
