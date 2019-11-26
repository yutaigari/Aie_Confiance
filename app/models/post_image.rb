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
  validates :content, presence: true, length: { minimum: 2, maximum: 140 }
  validate :image_count_valid?
  
  acts_as_taggable  # acts_as_taggable_on :tags のエイリアス
  mount_uploaders :post_img_name, PostImgNameUploader
  serialize :post_img_name, JSON
  
  private
  #画像数の制限
  def image_count_valid?
    if post_img_name.count > 5
      errors.add(:post_img_name, "画像数を４個以内に")
    end
  end
end

