class CreateMixSounds < ActiveRecord::Migration[5.2]
  def change
    create_table :mix_sounds do |t|
      t.belongs_to :mix, index: true
      t.belongs_to :sound, index: true

      t.timestamps
    end
  end
end
