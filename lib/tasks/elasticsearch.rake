namespace :elasticsearch do
  task :index_models => :environment do
    Article.import
    Discussion.import
  end
end