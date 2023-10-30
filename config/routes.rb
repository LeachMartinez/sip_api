Rails.application.routes.draw do
  post "/sign_in", to: "authorize#sign_in"
  post "/sign_up", to: "authorize#sign_up"
  get "/refresh", to: "authorize#refresh"
  post "/logout", to: "authorize#logout"
  resources :user
  resources :contacts
end
