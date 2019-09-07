class DropCategorization < ActiveRecord::Migration[5.2]
  def up
    drop_table :categorizations
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
