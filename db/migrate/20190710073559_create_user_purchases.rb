class CreateUserPurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :user_purchases do |t|
      t.string :appsflyer_id
      t.string :receipt
      t.string :store
      t.string :event_key

      t.timestamps
    end
  end
end
