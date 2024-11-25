class Commodity < ApplicationRecord
  mount_uploader :homepage, PhotoUploader
  
  validates :name, presence: true
  validates :price, presence: true
  validates :introduction, presence: true
  validates :business_id, presence: true
  validates :homepage, presence: true, on: :update_homepage
end
