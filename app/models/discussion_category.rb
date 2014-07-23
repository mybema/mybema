# == Schema Information
#
# Table name: discussion_categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  slug              :string(255)
#  description       :text
#  discussions_count :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#

class DiscussionCategory < ActiveRecord::Base
  has_many :discussions, dependent: :nullify

  before_save :sluggify_name

  private

  def sluggify_name
    self.slug = name.parameterize
  end
end