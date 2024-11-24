class Deal < ApplicationRecord
  validates :seller, presence: true
  validates :customer, presence: true
  validates :date, presence: true
  validates :comment, presence: true
end
