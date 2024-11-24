class Commodity < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :introduction, presence: true
  validates :business_id, presence: true
  validates :homepage, presence: true
end
