class User < ApplicationRecord
  validates :auth, uniqueness: true
  validates :name, uniqueness: true
end
