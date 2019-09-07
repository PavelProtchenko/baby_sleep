class CreateSounds < ActiveRecord::Migration[5.2]
  def change
    create_table :sounds do |t|
      t.string :image_url
      t.string :file_url
      t.string :name

      t.timestamps
    end
  end
end
