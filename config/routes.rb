Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get 'auth', to: 'auth#auth'
      resources :users, only: %i[index show] do
        member do
          get :follows, action: :follows
          post :follows, action: :post_follows
          get :followers
          get :last_week_order_sleep_time, action: :last_week_order_sleep_time
        end
      end
      resources :sleeps, only: %i[] do
        collection do
          get :clockin
          get :clockout
        end
      end
      resources :follows, only: %i[destroy]
    end
  end
end
