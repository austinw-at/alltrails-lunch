Rails.application.routes.draw do
  root "users#index"

  resources :users do
    member do
      patch :tokens, to: "users/tokens#update"
    end
  end

  post "search", to: "search#index", format: :json
end
