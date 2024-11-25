class User < ApplicationRecord
  has_secure_password
  mount_uploader :avator, PhotoUploader

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
  validates :avator, presence: true, on: :update_avator
end
