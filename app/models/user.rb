class User < ApplicationRecord
  has_many :follows, foreign_key: :from_user_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, foreign_key: :to_user_id, class_name: 'Follow', dependent: :destroy
  has_many :sleeps, dependent: :destroy

  validates :auth, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  scope :left_join_followed_by_me, lambda { |user|
    joins("LEFT OUTER JOIN follows ON users.id = follows.to_user_id AND follows.from_user_id = #{user.id}")
      .select('users.*', 'follows.id as follow_id')
  }
end
