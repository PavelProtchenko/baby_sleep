class AddParametersToUserPurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :user_purchases, :product_id, :string
    add_column :user_purchases, :application_version, :integer
    add_column :user_purchases, :is_trial_period, :boolean
    add_column :user_purchases, :expires_date_ms, :datetime
    add_column :user_purchases, :latest_receipt, :string
  end
end
