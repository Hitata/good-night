Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get 'auth', to: 'auth#auth'
      resources :users, only: %i[index show]
      resources :sleeps, only: %i[] do
        collection do
          get :clockin
          get :clockout
        end
      end
    end
  end
end
