Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get 'auth', to: 'auth#auth'
      resources :users, only: %i[index show]
    end
  end
end
