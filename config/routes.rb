# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'
  get 'welcome', to: 'welcome#index'
  post 'search', to: 'search#search'

  resources :sessions, only: %i[create destroy]
  resources :activity_logs, only: :index
  resources :users, only: %i[create destroy]
  resources :user_groups, only: %i[index update destroy]
  resources :repetitive_tasks, only: %i[index new create edit update destroy] do
    resources :repetitive_task_logs, only: %i[create update destroy]
  end
end
