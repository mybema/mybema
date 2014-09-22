# == Schema Information
#
# Table name: guidelines
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Guideline < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end