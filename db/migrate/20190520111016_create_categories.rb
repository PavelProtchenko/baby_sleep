class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :subtitle
      t.string :image_url
      t.string :main_image_url
      t.integer :position, default: 0
      t.boolean :onboarding, default: false
      t.boolean :default_sounds_title, default: false
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
