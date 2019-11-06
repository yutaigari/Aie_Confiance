class PostComment < ApplicationRecord
  
  validates :comment, presence: true, length: { in: 2..100 }
  
  belongs_to :user
  belongs_to :post_image
end
