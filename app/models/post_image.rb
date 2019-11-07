class PostImage < ApplicationRecord
  
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  default_scope -> { order(created_at: :desc) }
  #デフォルトの順序を新しい投稿から順に並べる
  validates :post_img_name, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  mount_uploader :post_img_name, PostImgNameUploader
end

