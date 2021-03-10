Rails.application.routes.draw do

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # if Rails.env.production?
  #   constraints(subdomain: '') do
  #     match "(*x)" => redirect do |params, request|
  #       URI.parse(request.url).tap { |x| x.host = "www.#{x.host}" }.to_s
  #     end
  #   end
  # end

  # mount ActionCable.server => '/cable'
  devise_for :users
  # Todas las rutas del panel tiene que tener panel
  devise_scope :user do
    get 'panel/login', to: 'devise/sessions#new'
  end

    # mount Resque::Server.new, at: "/resque"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "titlepage#index"
  get "privacy_policy", to: "titlepage#privacy_policy"
  get "stations_supervisor", to: "titlepage#stations_supervisor"

  resources :articles, param: :slug, only: [:show] do
      get :search_hashtag, on: :collection
  end
  #resources :stations, param: :slug

  get "/sitemap.xml" => "sitemap#index", :format => "xml"
  get "/sitemap/:sitemap/index.xml" => "sitemap#index", :format => "xml"
  get "/sitemap/:id/:sitemap" => "sitemap#sitemap", :format => "xml"


  resources :sections, only: [:show], param: :slug
  get "tactica", to: "sections#sports"
  get "corporativo", to: "sections#corporation"
  resources :relationships
  resources :stations do 
    get "articles", to: "stations#articles"
  end

  resources :cameras
  
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

    get "hit_objectives/new_author_objectives", to: "hit_objectives#new_author_objectives"
    post "hit_objectives/new_author_objectives", to: "hit_objectives#new_author_objectives"

    get "hit_objectives/new_user_objectives", to: "hit_objectives#new_user_objectives"
    post "hit_objectives/new_user_objectives", to: "hit_objectives#new_user_objectives"

    get "edit_multiple_hit_objectives", to: "hit_objectives#edit_multiple"
    get "edit_multiple_author_objectives", to: "hit_objectives#edit_author_objectives"
    get "edit_user_objectives", to: "hit_objectives#edit_user_objectives"


    #post "edit_multiple_hit_objectives", to: "hit_objectives#edit_multiple"
    get "update_multiple_hit_objectives", to: "hit_objectives#update_multiple"
    patch "update_multiple_hit_objectives", to: "hit_objectives#update_multiple"
    post "update_multiple_hit_objectives", to: "hit_objectives#update_multiple"

    get "author_update_multiple_hit_objectives", to: "hit_objectives#author_update_multiple"
    patch "author_update_multiple_hit_objectives", to: "hit_objectives#author_update_multiple"
    post "author_update_multiple_hit_objectives", to: "hit_objectives#author_update_multiple"

    get "user_update_multiple_hit_objectives", to: "hit_objectives#user_update_multiple"
    patch "user_update_multiple_hit_objectives", to: "hit_objectives#user_update_multiple"
    post "user_update_multiple_hit_objectives", to: "hit_objectives#user_update_multiple"


    resources :notifications do 
      get :autocomplete_article_name, on: :collection
      get :autocomplete_station_name, on: :collection
      get :autocomplete_camera_name, on: :collection

    end

    resources :highlights, param: :slug

    resources :articles, param: :slug do 
      post :publish_now
      get :publish_now
      get :autocomplete_article_name, on: :collection
      get :gallery_images
      post :gallery_images
      post :set_highlight_from_id
      post :set_recommendation_from_id
    end
    post "set_highlight_from_id", to: "articles#set_highlight_from_id"
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
      
      resources :related_sections
    end
    resources :hits do 
      get :graph, on: :collection
      post :graph, on: :collection
      get :author_graph, on: :collection
      post :author_graph, on: :collection
      get :user_graph, on: :collection
      post :user_graph, on: :collection
    end
    resources :banners
    resources :relationships, param: :slug
    resources :hit_objectives
    resources :controls do 
      get :done, on: :collection
      get :download_controls, on: :collection
    end
    # get "panel/controls/done", to: "panel/controls#done"
    resources :hashtags, only: :index do
      get :autocomplete_hashtag_name, on: :collection
      get :switch_hashtag, on: :collection
      post :switch_hashtag, on: :collection
    end



    get "all_articles", to: "articles#all_articles"
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
    
    resources :sports

    #ROUTES FROM ANGULAR
    get "new-banner", to: "new_banners#index"
    get "new-banner/create", to: "new_banners#index"
    get "new-banner/edit/:id", to: "new_banners#index"

    get "preference", to: "new_banners#index"
    get "preference/create", to: "new_banners#index"
    get "preference/edit/:id", to: "new_banners#index"

  end
  # get "panel/keywords/edit_multiple", to: "panel/keywords#edit_multiple"
  # get "panel/keywords/update_multiple", to: "panel/keywords#update_multiple"
  # post "panel/keywords/update_multiple", to: "panel/keywords#update_multiple"
   

  get "search_article", to: "titlepage#search_article"
  post "search_article", to: "titlepage#search_article"
  get "search_results", to: "titlepage#search_results"

  get "panel/sections/set_highlight_and_recomendations", to: "panel/sections#set_highlight_and_recomendations"
  post "panel/sections/set_highlight_and_recomendations", to: "panel/sections#set_highlight_and_recomendations"
  # NOTAS DE PROGRAMADOR 
  # REVISAR DONDE SE USA KEYWORD SHOW A 

  resources :keywords, param: :slug, except: [:index, :show, :edit, :update, :destroy, :new, :create] do
    get :show_keyword
  end


  namespace :api do
    namespace :v1 do

      get "preferences", to: "preferences#index"
      get "preference/:id", to: "preferences#find"
      post "preference", to: "preferences#create"
      post "preference/:id", to: "preferences#update"
      delete "preference/:id", to: "preferences#delete"
      get "preference/key/:key", to: "preferences#find_by_key"

      resources :articles, only: [:index, :show] do
        collection do 
          get "most_visited"
          get "search"
        end
      end
      resources :devices, only: [:create]
      resources :banners, only: [:index]
      get "get_banners", to: "banners#get_banners"
      resources :podcasts, only: [:index]
      get "podcast/:id/increment_one_second", to: "podcasts#add_one_second_played"
      resources :stations, only: [:index, :show]
      resources :cameras, only: [:index, :show]
      resources :sports, only: [:index]
      # , to: "api/v1/articles#most_visited"

      resources :sections, only: [:index, :show] do 
        get "articles", to: "sections#get_articles"
      end
      get "highlights", to: "articles#highlights"
      get "latest_collaborator_articles", to: "articles#latest_collaborator_articles"
      get "latest_special_investigation", to: "articles#latest_special_investigation"
      get "latest_special_investigation_articles", to: "articles#latest_special_investigation_articles"
      get "latest_complaints_articles", to: "articles#latest_complaints_articles"
      get "get_global_recommendations", to: "articles#get_global_recommendations"
      
      get "search", to: "articles#search"
      post "search", to: "articles#search"

      get "search_with_dates_and_category", to: "articles#search_with_dates_and_category"
      post "search_with_dates_and_category", to: "articles#search_with_dates_and_category"
      
      get "related_by_hashtags", to: "articles#related_by_hashtags"
      post "related_by_hashtags", to: "articles#related_by_hashtags"
      get "search_hashtag", to: "articles#search_hashtag"
      post "search_hashtag", to: "articles#search_hashtag"

      #START NEW BANNERS
      get "new_banner", to: "new_banners#index"
      get "new_banner/now", to: "new_banners#get_new_banners_now"
      get "new_banner/show_now/:type", to: "new_banners#get_new_banner_show_now"
      get "new_banner/:id", to: "new_banners#find_by_id"
      post "new_banner", to: "new_banners#create"
      patch "new_banner/:id", to: "new_banners#update"
      delete "new_banner/:id", to: "new_banners#delete"
      #END NEW BANNERS
      
    end
  end
  

  get 'set_slug', to: "titlepage#set_slug"
  post 'set_slug', to: "titlepage#set_slug"

  get 'set_image', to: "titlepage#set_image"
  post 'set_image', to: "titlepage#set_image"

  get 'publish_highlights', to: "titlepage#publish_highlights"
  get '/:id', to: 'stations#show'    

  

end
