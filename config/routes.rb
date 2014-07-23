Mybema::Application.routes.draw do
  root 'discussions#index'

  resources :discussion_categories, path: 'categories' do
    resources :discussions do
      resources :discussion_comments
    end
  end
end