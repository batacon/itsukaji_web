Rails.application.routes.draw do
  root 'home#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[create destroy]
  resources :users, only: %i[create destroy]
  resources :repetitive_tasks, only: %i[index new create edit update destroy] do
    resources :repetitive_task_logs, only: %i[create destroy]
  end
  resources :user_groups, only: %i[index update]
  resources :welcome, only: %i[index]
end
