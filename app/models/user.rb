class User < ApplicationRecord
  require "securerandom"
  validates :username , presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
