Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { formate: 'json' } do
    scope '(v:version)', format: false, defaults: { format: :json, version: 1 }, constraints: { version: /[1]/ } do
      resources :users
    end
  end
end
