Rails.application.routes.draw do
  # =======================
  # 1. HEALTH CHECKS (Primero, para Heroku)
  # =======================
  root to: "titlepage#index"  # Solo un root definition!
  get '/up', to: proc { [200, {}, [''] }  # Health check endpoint
  get '/health', to: proc { [200, {}, ['OK'] }  # Alternativo

  # =======================
  # 2. DEVISE (Autenticación)
  # =======================
  devise_for :users, skip: [:sessions]
  as :user do
    get 'panel/login' => 'devise/sessions#new', as: :new_user_session
    post 'panel/login' => 'devise/sessions#create', as: :user_session
    delete 'panel/logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  # =======================
  # 3. PUBLIC ROUTES
  # =======================
  resources :articles, param: :slug, only: [:show] do
    collection do
      get :search_hashtag
    end
  end

  get "/articles/hashtag/:slug", to: "articles#filter_by_hashtag"
  
  resources :sections, only: [:show], param: :slug do
    member do
      get :sports, to: "sections#sports"
      get :corporation, to: "sections#corporation"
    end
  end

  resources :stations do 
    get "articles", on: :member
  end

  resources :cameras
  resources :relationships
  resources :highlights do
    collection do
      get :autocomplete_article_name
    end
  end

  # Páginas estáticas
  get "privacy_policy", to: "titlepage#privacy_policy"
  get "about_us", to: "titlepage#about_us"
  get "search_article", to: "titlepage#search_article"
  get "search_results", to: "titlepage#search_results"
  get "stations_supervisor", to: "titlepage#stations_supervisor"
  get "collaborators", to: "relationships#collaborators"

  # Sitemaps
  get "/google_news.xml" => "sitemap#google_news", format: "xml"
  get "/sitemap.xml" => "sitemap#index", format: "xml"
  get "/sitemap/:sitemap/index.xml" => "sitemap#index", format: "xml"
  get "/sitemap/:id/:sitemap" => "sitemap#sitemap", format: "xml"

  # =======================
  # 4. PANEL (Admin)
  # =======================
  namespace :panel do
    get "/", to: "panel#panel"  # Dashboard
    
    # Artículos
    resources :articles, param: :slug do
      member do
        post :publish_now
        get :gallery_images
        post :set_highlight_from_id
        post :set_recommendation_from_id
      end
      collection do
        get :all_articles
        get :autocomplete_article_name
      end
    end

    # Multimedia
    resources :cameras
    resources :banners
    resources :highlights, param: :slug
    get 'highlights/experimental', to: 'highlights#experimental'

    # Secciones
    resources :sections, param: :slug do
      member do
        get :select_highlights
        post :set_highlight
        get :select_global_recommendations
        post :set_global_recommendations
      end
      resources :related_sections
    end

    # Estadísticas
    resources :analytics, only: [:index] do
      collection do
        get "export/:from/:to", to: "analytics#export_articles"
      end
    end

    # Usuarios y colaboradores
    resources :users
    resources :authors
    resources :relationships, param: :slug do
      collection do
        get :new_collaborator
        get :collaborators
        get :new_complaint
        get :complaints
      end
    end

    # Configuración
    resources :preferences, only: [:index]
    resources :hashtags, only: :index do
      collection do
        get :autocomplete_hashtag_name
        get :switch_hashtag
        post :switch_hashtag
      end
    end
  end

  # =======================
  # 5. API
  # =======================
  namespace :api do
    namespace :v1 do
      # Artículos
      resources :articles, only: [:index, :show] do
        collection do 
          get :most_visited
          get :search
          get :highlights
          get :latest_collaborator_articles
          get :latest_special_investigation
          get :latest_complaints_articles
          get :get_global_recommendations
        end
      end

      # Multimedia
      resources :banners, only: [:index]
      resources :podcasts, only: [:index] do
        member do
          get :increment_one_second
        end
      end

      # Secciones
      resources :sections, only: [:index, :show] do 
        get :articles, on: :member
      end

      # Dispositivos
      resources :devices, only: [:create]
    end
  end

  # =======================
  # 6. CATCH-ALL (Último!)
  # =======================
  get '/:id', to: 'stations#show', constraints: { id: /[0-9]+/ }  # Solo números
end