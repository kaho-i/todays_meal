class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites

  has_one_attached :image

  validates :shop_name, presence: true
  validates :body, presence: true

  #def get_image(width, height)
    #image.variant(resize_to_limit: [width, height]).processed
  #end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
