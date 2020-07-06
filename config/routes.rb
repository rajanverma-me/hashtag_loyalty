Rails.application.routes.draw do
  devise_for :merchants
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/dashboard', to: "dashboard#index"
  get '/admin', to: "admin#index"
  get '/transactions', to: "dashboard#transactions"
  post '/upload', to: "admin#upload"
end
