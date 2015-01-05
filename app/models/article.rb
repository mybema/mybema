# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  body       :text
#  title      :string(255)
#  section_id :integer
#  created_at :datetime
#  updated_at :datetime
#  excerpt    :string(255)
#  hero_image :string(255)
#

require 'file_size_validator'

class Article < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mount_uploader :hero_image, ArticleHeroUploader
  validates :hero_image, file_size: { maximum: 1.megabytes.to_i } if Proc.new { |article| article.hero_image.exists? }

  index_name "article_#{Rails.env}"

  belongs_to :section, counter_cache: true
  validates_uniqueness_of :title, scope: [:section_id]
  validates :title, :body, presence: true

  def class_name
    'article'
  end

  def markdown_body
    # This is just because I'm lazy right now. This WILL very soon be moved to a Decorator method.
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(body).html_safe
  end
end
