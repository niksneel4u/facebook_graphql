Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :groups do
        collection do
          post 'groups_list'
          post 'add_fav_groups'
        end
      end
      resources :users
    end
  end
end
