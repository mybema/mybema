# == Schema Information
#
# Table name: hero_messages
#
#  id         :integer          not null, primary key
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

class HeroMessage < ActiveRecord::Base
  validates_presence_of :message
end