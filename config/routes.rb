Qna::Application.routes.draw do
  
  devise_for :users
  resources :questions	

end
