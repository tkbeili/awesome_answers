AwesomeAnswers::Application.routes.draw do


  devise_for :users
  resources :questions do 
    resources :votes, only: [:create, :update, :destroy]
    resources :likes, only: :create do
      delete :destroy, on: :collection
    end
    get :top_questions, on: :collection
    resources :answers
  end

  resources :answer, only: [] do
    resources :likes, only: :create do
      delete :destroy, on: :collection
    end
  end

  root 'questions#index'

end