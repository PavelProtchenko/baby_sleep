class CreateMixCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :mix_categories do |t|
      t.belongs_to :mix, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
