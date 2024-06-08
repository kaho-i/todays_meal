class Restrant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :reservations
  
  validates :name, length: { in: 2..20 }
  validates :telephone_number, presence: true
  
  def self.search_for(content, method)
    if method == 'perfect'
      Restrant.where(name: content)
    elsif method == 'forward'
      Restrant.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Restrant.where('name LIKE ?', '%' + content)
    else
      Restrant.where('name LIKE ?', '%' + content + '%')
    end
  end
end
