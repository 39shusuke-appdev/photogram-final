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
  
  has_many(:photos, :class_name =>"Photo", :foreign_key => "owner_id")

# フォローをした、されたの関係
  has_many :followrequests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :reverse_of_followrequests, class_name: "FollowRequest", foreign_key: "recipient_id", dependent: :destroy

# 一覧画面で使う
has_many :followings, through: :followrequests, source: :recipient
has_many :followers, through: :reverse_of_followrequests, source: :sender

end
