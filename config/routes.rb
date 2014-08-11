AwesomeAnswers::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :questions do 
    resources :votes, only: [:create, :update, :destroy]
    resources :likes, only: :create do
      delete :destroy, on: :collection
    end
    get :top_questions, on: :collection
    resources :answers
  end

  resources :answer, only: [] do
    resources :comments
    resources :likes, only: :create do
      delete :destroy, on: :collection
    end
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :questions
    end
  end

  resources :tips, only: [:new, :create]

  root 'questions#index'

end