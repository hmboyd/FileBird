Rails.application.routes.draw do
  resources :downloaders
  resources :file_listings
  resources :settings

  get 'downloaders/:id/download' => 'downloaders#start_job', as: 'start_download_job'

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web, at: '/sidekiq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
