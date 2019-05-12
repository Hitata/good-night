class User < ApplicationRecord
  has_many :follows, foreign_key: :from_user_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, foreign_key: :to_user_id, class_name: 'Follow', dependent: :destroy
  has_many :sleeps, dependent: :destroy

  validates :auth, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
