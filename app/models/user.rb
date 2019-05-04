class User < ApplicationRecord
  has_many :followings, foreign_key: :from_user_id, class_name: 'Follow', dependent: :destroy
  has_many :follows, foreign_key: :to_user_id, class_name: 'Follow', dependent: :destroy

  validates :auth, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
