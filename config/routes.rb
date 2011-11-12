Qna::Application.routes.draw do
  
  devise_for :users

  resources :questions, :except => [:destroy, :show] do
  	collection do
  		get 'my-questions', action: 'my_questions', as: 'my'
  	end
  	resources :answers, :except => :show
  end

  root to: "questions#index"
end
