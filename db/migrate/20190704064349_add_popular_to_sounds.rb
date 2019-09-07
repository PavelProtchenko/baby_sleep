class AddPopularToSounds < ActiveRecord::Migration[5.2]
  def change
    add_column :sounds, :popular, :boolean, default: false
  end
end
