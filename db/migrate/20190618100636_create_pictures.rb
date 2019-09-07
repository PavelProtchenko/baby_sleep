class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :body_image_url

      t.timestamps
    end
  end
end
