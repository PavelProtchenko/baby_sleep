class AddDeletedToSounds < ActiveRecord::Migration[5.2]
  def change
    add_column :sounds, :deleted, :boolean, default: false
  end
end
