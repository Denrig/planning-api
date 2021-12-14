# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :rooms, only: %i[create show]
      resources :users, only: %i[show update create]
      resources :join_room, only: :create
    end
  end
end
