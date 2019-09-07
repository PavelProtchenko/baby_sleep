class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :firs_name
      t.string :last_name
      t.string :email
      t.string :roles

      t.timestamps
    end
  end
end
