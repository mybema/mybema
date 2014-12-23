Mybema::Application.routes.draw do
  require 'sidekiq/web'

  authenticate :admin do
    mount Sidekiq::Web => 'admin/sidekiq'
  end

  devise_for :admins
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'home#index'

  resources :articles, only: [:show]
  resources :discussions
  resources :discussion_comments
  resources :sections

  get 'profile' => 'users#profile'
  patch 'profile/update' => 'users#update_profile', as: :user

  #Search
  get 'search' => 'search#results', as: :search

  # API
  namespace :api do
    get 'prefetch/articles' => 'search#typeahead_article_prefetch'
    get 'prefetch/discussions' => 'search#typeahead_discussion_prefetch'
  end

  # Admin section
  get 'admin' => 'admin/overview#index'
  get 'admin/users' => 'admin/users#index'
  put 'admin/discussions/:id/toggle-visibility' => 'admin/discussions#toggle_visibility', as: :admin_toggle_discussion_visibility
  put 'admin/comments/:id/toggle-visibility' => 'admin/discussion_comments#toggle_visibility', as: :admin_toggle_comment_visibility
  patch 'admin/guest-posting/toggle' => 'admin/app_settings#toggle_guest_posting', as: :admin_toggle_guest_posting
  get 'admin/profile' => 'admin/profile#edit', as: :admin_profile
  patch 'admin/profile' => 'admin/profile#update'

  scope :admin, module: 'admin' do
    resources :admins, only: [:index, :new, :create, :destroy], as: :administrators
    resources :guidelines, only: [:index, :new, :create, :destroy], as: :guidelines
    resources :discussions, only: [:index, :edit, :update, :destroy], as: :admin_discussions
    resources :comments, only: [:index, :edit, :update, :destroy], as: :admin_comments, controller: 'discussion_comments'
    resources :sections, as: :admin_sections do
      resources :articles, except: [:index, :show]
    end
    resources :hero_messages, only: [:update]
    resources :articles, only: :index, as: :admin_articles
    resources :app_settings
  end
end