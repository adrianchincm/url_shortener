# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/u/:slug', to: 'links#redirect', as: :short
  resources :links, except: [:destroy]
  root to: 'home#index'
end
