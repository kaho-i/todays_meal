class Reservation < ApplicationRecord
  
  belongs_to :user
  belongs_to :restrant
  
  enum status:{
    before_reservation: 0,
    cancel: 1,
    completed: 2
  }
  
  validates :date, presence: true
  validates :member, presence: true
  
 
end
