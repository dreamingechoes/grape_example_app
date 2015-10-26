Rails.application.routes.draw do
  resources :reviews, only: [:index, :show]
  resources :products, only: [:index, :show]
  devise_for :users

  mount GrapeExampleApp::V1 => '/'
  mount GrapeSwaggerRails::Engine, at: "/documentation"

  get 'about' => 'visitors#about', as: :about
  root to: 'visitors#about'
end
