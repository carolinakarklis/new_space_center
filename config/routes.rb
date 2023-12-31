Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :space_vehicles, only: [:index, :create, :update, :show]
        resources :space_travels, only: [:index, :create, :update] do
          post 'fail', to: 'space_travels#fail'
          post 'abort', to: 'space_travels#abort'
          post 'start', to: 'space_travels#start'
        end
      end
    end
  end
end
