Rails.application.routes.draw do
  root to: "static_pages#home"
  
  get "static_pages/home"
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"

  resources :users, only: %i(new create)

end
