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
  get 'admin/comments' => 'admin/discussion_comments#index'
  get 'admin/users' => 'admin/users#index'
  put 'admin/discussions/:id/toggle-visibility' => 'admin/discussions#toggle_visibility', as: :admin_toggle_discussion_visibility

  scope :admin, module: 'admin' do
    resources :guidelines, only: [:index, :new, :create, :destroy], as: :guidelines
    resources :discussions, only: [:index, :edit, :update, :destroy], as: :admin_discussions
    resources :sections, as: :admin_sections
  end
end