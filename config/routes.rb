require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'homepage#home'

  delete '/delete_user/:uuid', to: 'homepage#delete_user', as: :delete_user
  get :user_counts, to: 'homepage#user_counts'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  mount Sidekiq::Web => '/sidekiq'
end
