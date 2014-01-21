AwesomeAnswers::Application.routes.draw do
  resources :questions do 
    get :like, on: :member
  end

  root 'questions#index'

end