class AddLockToCategorySounds < ActiveRecord::Migration[5.2]
  def change
    add_column :category_sounds, :lock, :boolean, default: false
  end
end
