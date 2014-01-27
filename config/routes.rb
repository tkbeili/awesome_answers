AwesomeAnswers::Application.routes.draw do
  devise_for :users
  resources :questions do 
    get :like, on: :member
    get :top_questions, on: :collection
    resources :answers
  end

  root 'questions#index'

end