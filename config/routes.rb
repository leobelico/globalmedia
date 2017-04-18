Rails.application.routes.draw do
  devise_for :users
  # Todas las rutas del panel tiene que tener panel
  devise_scope :user do
    get 'panel/login', to: 'devise/sessions#new'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "titlepage#index"
  
  resources :articles, param: :slug, only: [:show] do
      get :search_hashtag, on: :collection
  end
  #resources :stations, param: :slug


  resources :sections, only: [:show], param: :slug 


  
  get "panel", to: "panel/panel#panel"

  authenticated :user do 
    root to: "panel/panel#panel", as: "authenticated_root"
  end
  


  resources :highlights do 
  	get :autocomplete_article_name, on: :collection
  end


  namespace :panel do
   
    resources :keywords, param: :slug 
      

    get "edit_multiple_keywords", to: "keywords#edit_multiple"
    #post "edit_multiple_keywords", to: "keywords#edit_multiple"
    get "update_multiple_keywords", to: "keywords#update_multiple"
    patch "update_multiple_keywords", to: "keywords#update_multiple"
    post "update_multiple_keywords", to: "keywords#update_multiple"

    resources :highlights, param: :slug
    resources :articles, param: :slug
    resources :stations, param: :slug
    resources :timetables, only: [:show, :destroy] 
    resources :sections, param: :slug 
    resources :hits
    resources :banners

    get "set_highlight_and_recomendations", to: "sections#set_highlight_and_recomendations"
    post "set_highlight_and_recomendations", to: "sections#set_highlight_and_recomendations"

    get "show_global_recommendations", to: "panel#show_global_recommendations"
  get "set_global_recommendations", to: "panel#set_global_recommendations"
  post "set_global_recommendations", to: "panel#set_global_recommendations"
  end
  # get "panel/keywords/edit_multiple", to: "panel/keywords#edit_multiple"
  # get "panel/keywords/update_multiple", to: "panel/keywords#update_multiple"
  # post "panel/keywords/update_multiple", to: "panel/keywords#update_multiple"
   

  resources :users
  # NOTAS DE PROGRAMADOR 
  # REVISAR DONDE SE USA KEYWORD SHOW A 

  resources :keywords, param: :slug, except: [:index, :show, :edit, :update, :destroy, :new, :create] do
    get :show_keyword
  end


  
  



  

end
