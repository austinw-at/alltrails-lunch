Rails.application.routes.draw do
  root "users#index"

  resources :users do
    member do
      patch :tokens, to: "users/tokens#update"
    end
  end

  post "search", to: "api/v1/search_results#index", format: :json

  namespace :api do
    namespace :v1 do
      post "search_results", to: "search_results#index", format: :json
      resources :favorites, format: :json
    end
  end
end
