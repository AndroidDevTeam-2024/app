class Message < ApplicationRecord
  validates :date, presence: true
  validates :content, presence: true
  validates :publisher, presence: true
  validates :acceptor, presence: true
end
