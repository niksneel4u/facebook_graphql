Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :groups do
        collection do
          get 'groups_list'
        end
      end
    end
  end
end
