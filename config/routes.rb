Mybema::Application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'home#index'

  resources :articles
  resources :discussions
  resources :discussion_categories, path: 'categories' do
    resources :discussions, only: :index
  end
  resources :discussion_comments
  resources :sections

  #Search
  get 'search' => 'search#results', as: :search
end