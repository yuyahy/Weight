Rails.application.routes.draw do
  root   'human#index'
  get    '/signup',  to: 'human#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  #post   '/human/human_id/weightposts/id',  to: 'weightposts#update'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :human do
  resources :weightposts
  end
end
