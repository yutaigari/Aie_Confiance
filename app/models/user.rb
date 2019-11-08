class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
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
  
end
