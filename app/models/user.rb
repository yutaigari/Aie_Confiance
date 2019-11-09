class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower   
  
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :self_introduction, length: { maximum: 500 }
  
  mount_uploader :img_name, ImgNameUploader
  enum sex: {男:0, 女:1}
  
  def self.search(search)
    if search
      User.where(['name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end
  
  #selfをつけることで現在のユーザーと関連付けできる（なくても可）
  #ユーザーをフォローする
  def follow(other_user)
    self.active_relationships.create(followed_id: other_user.id)
  end
  #ユーザーをアンフォローする
  def unfollow(other_user)
    self.active_relationships.find_by(followed_id: other_user.id).destroy
  end
  #現在のユーザーがフォローしていたらtruewを返す
  def following?(other_user)
    self.following.include?(other_user)
  end
  
end
