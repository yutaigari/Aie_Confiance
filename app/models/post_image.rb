class PostImage < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  #デフォルトの順序を新しい投稿から順に並べる
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  mount_uploader :post_img_name, PostImgNameUploader
end
