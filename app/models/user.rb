# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  username   :string(255)
#  ip_address :string(255)
#  guid       :string(255)
#  banned     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
end
