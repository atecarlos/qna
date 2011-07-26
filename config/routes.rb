Qna::Application.routes.draw do
  
  devise_for :users

  get "questions/" => "questions#index"

end
