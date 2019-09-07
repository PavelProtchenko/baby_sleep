class CreateCategorySounds < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sounds, id: false do |t|
      t.references :category, null: false, foreign_key: true
      t.references :sound, null: false, foreign_key: true

      t.timestamps
    end
  end
end
