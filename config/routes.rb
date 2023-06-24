Rails.application.routes.draw do
  resources :blogs do
    resources :comments, module: :blogs, only: %i[index create]
  end
  resources :topics, only: %i[new create index show]

  devise_for :users, controllers: { sessions: "users/sessions" }

  root to: "pages#home"

  resources :blogs do
    member do
      get :toggle_status
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
