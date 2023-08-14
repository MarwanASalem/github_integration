Rails.application.routes.draw do
  devise_for :users

  root "users#show"

  resources :users do
    collection do
      get :show
      patch :update_github_access_token
    end
  end

  resources :repositories, only: [:index] do
    collection do
      get :repo_details
    end
  end
end
