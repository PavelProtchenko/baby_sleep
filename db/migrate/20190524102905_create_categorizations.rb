class CreateCategorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :categorizations do |t|
      t.integer :category_id
      t.integer :categorizable_id
      t.string :categorizable_type

      t.timestamps
    end
    add_index :categorizations, [:category_id]
  end
end
