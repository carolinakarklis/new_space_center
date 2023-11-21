Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :space_vehicles, only: [:index, :create, :update]
        resources :space_travels, only: [:index, :create, :update]
      end
    end
  end
end
