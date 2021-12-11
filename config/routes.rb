# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :rooms, only: :create
      resources :users, only: %i[index create]
    end
  end
end
