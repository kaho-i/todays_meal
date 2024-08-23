class Reservation < ApplicationRecord
  
  belongs_to :user
  belongs_to :restrant
  
  validates :date, presence: true
  validates :member, presence: true
  
end
