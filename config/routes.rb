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

  # Admin section
  get 'admin' => 'admin/overview#index'
  get 'admin/discussions' => 'admin/discussions#index'
  get 'admin/comments' => 'admin/discussion_comments#index'
  get 'admin/users' => 'admin/users#index'

  scope :admin, module: 'admin' do
    resources :guidelines, only: [:index, :new, :create, :destroy]
  end
end