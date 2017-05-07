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
  resources :relationships
  resources :stations
  
  get "collaborators", to: "relationships#collaborators"
  get "about_us", to: "titlepage#about_us"

  
  get "panel", to: "panel/panel#panel"

  authenticated :user do 
    root to: "panel/panel#panel", as: "authenticated_root"
  end
  get :autocomplete_article_name, controller:"application"


  resources :highlights do 
  	get :autocomplete_article_name, on: :collection
  end

  namespace :panel do
   
    resources :keywords, param: :slug 
    resources :cameras

    get "edit_multiple_keywords", to: "keywords#edit_multiple"
    #post "edit_multiple_keywords", to: "keywords#edit_multiple"
    get "update_multiple_keywords", to: "keywords#update_multiple"
    patch "update_multiple_keywords", to: "keywords#update_multiple"
    post "update_multiple_keywords", to: "keywords#update_multiple"

    get "edit_multiple_hit_objectives", to: "hit_objectives#edit_multiple"
    #post "edit_multiple_hit_objectives", to: "hit_objectives#edit_multiple"
    get "update_multiple_hit_objectives", to: "hit_objectives#update_multiple"
    patch "update_multiple_hit_objectives", to: "hit_objectives#update_multiple"
    post "update_multiple_hit_objectives", to: "hit_objectives#update_multiple"
    resources :highlights, param: :slug

    resources :articles, param: :slug do 
      post :publish_now
      get :publish_now
      get :autocomplete_article_name, on: :collection
    
    end
    resources :stations, param: :slug do 
      resources :timetables 
      resources :podcasts 
    end
    resources :timetables, only: [:show, :destroy] 
    resources :sections, param: :slug do 
      get :select_highlights
      post :select_highlights
      post :set_highlight

      get :select_global_recommendations
      post :select_global_recommendations
      post :set_global_recommendations
      get :autocomplete_article_name, on: :collection
      
    end
    resources :hits
    resources :banners
    resources :relationships, param: :slug 
    resources :hit_objectives
    resources :controls
    resources :hashtags, only: :index do
      get :autocomplete_hashtag_name, on: :collection

    end


    get "new_collaborator", to: "relationships#new_collaborator"
    get "collaborators", to: "relationships#collaborators"

    get "new_complaint", to: "relationships#new_complaint"
    get "complaints", to: "relationships#complaints"

    get "add_article_to_investigations", to: "relationships#add_article_to_investigations"

     get "set_investigation_articles", to: "relationships#set_investigation_articles"
    post "set_investigation_articles", to: "relationships#set_investigation_articles"


    get "add_article_to_stations", to: "stations#add_article_to_stations"

    get "set_station_articles", to: "stations#set_station_articles"
    post "set_station_articles", to: "stations#set_station_articles"


    get "set_highlight_and_recomendations", to: "sections#set_highlight_and_recomendations"
    post "set_highlight_and_recomendations", to: "sections#set_highlight_and_recomendations"

    get "show_global_recommendations", to: "panel#show_global_recommendations"
    get "set_global_recommendations", to: "panel#set_global_recommendations"
    post "set_global_recommendations", to: "panel#set_global_recommendations"


    get "selecting_hashtags", to: "hashtags#selecting_hashtags"

    get "set_selected", to: "hashtags#set_selected"
    post "set_selected", to: "hashtags#set_selected"

    resources :users
    resources :article_relationships, only: [:show, :destroy]
    resources :authors
    
  end
  # get "panel/keywords/edit_multiple", to: "panel/keywords#edit_multiple"
  # get "panel/keywords/update_multiple", to: "panel/keywords#update_multiple"
  # post "panel/keywords/update_multiple", to: "panel/keywords#update_multiple"
   

  get "search_article", to: "titlepage#search_article"
  post "search_article", to: "titlepage#search_article"
  get "search_results", to: "titlepage#search_results"
  # NOTAS DE PROGRAMADOR 
  # REVISAR DONDE SE USA KEYWORD SHOW A 

  resources :keywords, param: :slug, except: [:index, :show, :edit, :update, :destroy, :new, :create] do
    get :show_keyword
  end


  
  



  

end
