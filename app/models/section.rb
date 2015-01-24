# == Schema Information
#
# Table name: sections
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  articles_count :integer          default("0")
#  created_at     :datetime
#  updated_at     :datetime
#

class Section < ActiveRecord::Base
  has_many :articles, dependent: :nullify
  validates :title, presence: true, uniqueness: true
  scope :with_articles, -> { includes(:articles).where('articles_count > 0') }
end
