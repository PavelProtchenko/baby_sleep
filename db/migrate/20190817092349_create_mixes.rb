class CreateMixes < ActiveRecord::Migration[5.2]
  def change
    create_table :mixes do |t|
      t.string :name
      t.string :image_url
      t.integer :duration
      t.integer :position, default: 0
      t.integer :volume, default: 0

      t.timestamps
    end
  end
end
