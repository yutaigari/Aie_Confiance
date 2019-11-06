class AddPostImgNameToPostImages < ActiveRecord::Migration[5.1]
  def change
    add_column :post_images, :post_img_name, :string
  end
end
