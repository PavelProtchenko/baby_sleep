class AddPositionToCategorySounds < ActiveRecord::Migration[5.2]
  def up
    add_column :category_sounds, :id, :primary_key
    add_column :category_sounds, :position, :integer, default: 0
  end

  def down
    remove_column :category_sounds, :id
    remove_column :category_sounds, :position
  end
end
