Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { formate: 'json' } do
    scope '(v:version)', format: false, defaults: { format: :json, version: 1 }, constraints: { version: /[1]/ } do
      resources :users
      resources :team_members, only: :index
      resources :projects, only: [] do
        collection do
          get :autocomplete
        end
      end
      resources :skills, only: [] do
        collection do
          get :autocomplete
        end
      end
    end
  end
end
