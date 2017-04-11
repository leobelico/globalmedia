Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "titlepage#index"
  resources :articles, param: :slug do
  	get :search_hashtag, on: :collection
  end

  resources :sections, param: :slug 

  resources :highlights do 
  	get :autocomplete_article_name, on: :collection
  end

end
