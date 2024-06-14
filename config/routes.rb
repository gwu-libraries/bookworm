# frozen_string_literal: true

Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  namespace :api do
    namespace :v1 do
      resources :works
      resources :investigations
      resources :keys

      get 'investigations/:investigation_id/works', to: 'investigations#work_list'

      get 'works/:id/tree', to: 'works#tree'
    end
  end
end
