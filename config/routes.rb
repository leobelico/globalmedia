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
  
  get "panel", to: "panel#panel"

  authenticated :user do 
    root to: "panel#panel", as: "authenticated_root"
  end
  
  resources :sections, param: :slug 

  resources :highlights do 
  	get :autocomplete_article_name, on: :collection
  end


  scope '/panel' do
    resources :keywords, except: [:show, :edit, :update, :destroy]
    resources :articles, param: :slug, except: [:show]
  end
  resources :users
  resources :keywords, only: [:show], param: :slug 
  
  get "panel/keywords/edit_multiple", to: "keywords#edit_multiple"

  get "panel/keywords/update_multiple", to: "keywords#update_multiple"
  post "panel/keywords/update_multiple", to: "keywords#update_multiple"
end
