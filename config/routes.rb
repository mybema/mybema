Mybema::Application.routes.draw do
  root 'discussions#index'

  resources :discussions
  resources :discussion_categories, path: 'categories'
  resources :discussion_comments
end