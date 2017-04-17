Rails.application.routes.draw do
  devise_for :users
  # Todas las rutas del panel tiene que tener panel
  devise_scope :user do
    get 'panel/login', to: 'devise/sessions#new'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "titlepage#index"
  
  resources :articles, param: :slug do
      get :search_hashtag, on: :collection
  end

  resources :sections, only: [:show], param: :slug 


  
  get "panel", to: "panel#panel"

  authenticated :user do 
    root to: "panel#panel", as: "authenticated_root"
  end
  


  resources :highlights do 
  	get :autocomplete_article_name, on: :collection
  end


  namespace :panel do
   
    resources :keywords, param: :slug do 

    end
    resources :articles, param: :slug
    resources :sections, param: :slug 
    resources :hits
    resources :banners

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

  get "panel/sections/set_highlight_and_recomendations", to: "sections#set_highlight_and_recomendations"
  post "panel/sections/set_highlight_and_recomendations", to: "sections#set_highlight_and_recomendations"
  get "panel/sections/admin_show", to: "sections#admin_show"



  get "panel/show_global_recommendations", to: "panel#show_global_recommendations"
  get "panel/set_global_recommendations", to: "panel#set_global_recommendations"
  post "panel/set_global_recommendations", to: "panel#set_global_recommendations"

end
