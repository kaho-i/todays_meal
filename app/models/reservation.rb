class Reservation < ApplicationRecord
  
  belongs_to :user
  belongs_to :shop
  
  validates :name, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :member, presence: true
  
end
