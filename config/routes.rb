Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :groups do
        collection do
          get 'groups_list'
          post 'add_fav_groups'
        end
      end
      resources :users do
        collection do
          post 'add_notification_time'
        end
      end
    end
  end
end
