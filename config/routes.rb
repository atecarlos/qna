Qna::Application.routes.draw do
  
  devise_for :users
  
  resources :questions do
  	collection do
  		get 'my-questions', action: 'my_questions', as: 'my'
  	end
  	resources :answers, only: [:create] 
  end

  root :to => "questions#index"
end
