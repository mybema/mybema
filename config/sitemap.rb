SitemapGenerator::Sitemap.default_host = AppSettings.first.domain_address
SitemapGenerator::Sitemap.create do
  Discussion.find_each do |discussion|
    add discussion_path(discussion.id), lastmod: discussion.updated_at
  end

  Article.find_each do |article|
    add article_path(article.id), lastmod: article.updated_at
  end
end