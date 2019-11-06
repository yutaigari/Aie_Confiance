class CreatePostImages < ActiveRecord::Migration[5.1]
  def change
    create_table :post_images do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :post_images, [:user_id, :created_at]
  end
end
