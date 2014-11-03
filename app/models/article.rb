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
#

class Article < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "article_#{Rails.env}"

  belongs_to :section, counter_cache: true
  validates_uniqueness_of :title, scope: [:section_id]
  validates :title, :body, presence: true

  def class_name
    'article'
  end
end