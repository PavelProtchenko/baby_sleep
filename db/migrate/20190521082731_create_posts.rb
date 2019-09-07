class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :image_url
      t.string :title
      t.text :body
      t.integer :position, default: 0
      t.string :publication

      t.timestamps
    end
  end
end
