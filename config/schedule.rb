env :PATH, ENV['PATH']

every 7.days, :at => '5:00 am', :roles => [:app] do
  rake "-s sitemap:refresh"
end