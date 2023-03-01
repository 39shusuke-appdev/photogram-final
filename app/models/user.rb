# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:comments, {
    :class_name => "Comment",
    :foreign_key => "author_id",
    :dependent => :destroy
  })

  has_many(:likes, {
    :class_name => "Like",
    :foreign_key => "fan_id"
  })
  
  has_many(:photos, :class_name =>"User")

end
