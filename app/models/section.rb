# == Schema Information
#
# Table name: sections
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  articles_count :integer          default(0)
#  created_at     :datetime
#  updated_at     :datetime
#

class Section < ActiveRecord::Base
  has_many :articles, dependent: :nullify

  scope :with_articles, -> { where('articles_count > 0') }
end
