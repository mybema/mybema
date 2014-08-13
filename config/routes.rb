Mybema::Application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :discussions
  resources :discussion_categories, path: 'categories' do
    resources :discussions, only: :index
  end
  resources :discussion_comments
end