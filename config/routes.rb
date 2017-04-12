Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "titlepage#index"
  
  resources :articles, param: :slug, only: [:show] do
      get :search_hashtag, on: :collection
  end


  resources :highlights do 
  	get :autocomplete_article_name, on: :collection
  end


  scope '/panel' do
    resources :keywords, except: [:show, :edit, :update, :destroy]
    resources :articles, param: :slug, except: [:show, :destroy]
    resources :sections, param: :slug, except: [:show, :destroy] 

  end
  resources :users
  resources :keywords, only: [:show], param: :slug 
  resources :sections, only: [:show], param: :slug 
  resources :articles, only: [:show], param: :slug 
  
  get "panel/sections/set_highlight_and_recomendations", to: "sections#set_highlight_and_recomendations"
  post "panel/sections/set_highlight_and_recomendations", to: "sections#set_highlight_and_recomendations"
  get "panel/sections/admin_show", to: "sections#admin_show"


  get "panel/keywords/edit_multiple", to: "keywords#edit_multiple"
  get "panel/keywords/update_multiple", to: "keywords#update_multiple"
  post "panel/keywords/update_multiple", to: "keywords#update_multiple"
end
