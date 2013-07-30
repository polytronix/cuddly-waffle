Pcms::Application.routes.draw do
  resources :films, except: [:show, :destroy] do
    member do
      get :split
      put :create_split
    end
    collection do
      get :edit_multiple
      put :update_multiple
    end
  end

  get 'imports', to: 'imports#home'
  post 'import_master_films', to: 'imports#import_master_films'
  post 'import_films', to: 'imports#import_films'
  post 'import_users', to: 'imports#import_users'
  post 'import_machines', to: 'imports#import_machines'
  post 'import_defects', to: 'imports#import_defects'

  get 'history/film_movements', to: 'history#film_movements', as: :film_movements_history
  get 'history/fg_film_movements', to: 'history#fg_film_movements', as: :fg_film_movements_history

  root to: 'films#index', defaults: { scope: "lamination" }
end
