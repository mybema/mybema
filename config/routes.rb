Mybema::Application.routes.draw do
  devise_for :users
  root 'discussions#index'

  resources :discussions
  resources :discussion_categories, path: 'categories'
  resources :discussion_comments
end