namespace :check_cancel_subscription do
  task cancel_trial_newcomers: :environment do
    get_users
    check_appsflyer_data
    Rails.logger.info "\n\n\n\n\n\n\n\n\n\n\n\n\n\nCancel subscription__#{Time.now}"
  end

  private

  def check_appsflyer_data
    UserPurchase.where('expires_date_ms < ?', Time.now)
                .where(is_trial_period: true).find_each do |user_purchase|
      user_purchase.event_key
      cancel_purchase_params = { appsflyer_id: user_purchase.appsflyer_id,
                                 event_key: user_purchase.event_key + '_DidCancelPurchase',
                                 store: user_purchase.store,
                                 product_id: user_purchase.product_id
                               }

      AppsflyerService.new(cancel_purchase_params).call
      SplunkService.new(cancel_purchase_params).call
    end
  end

  def get_users
    UserPurchase.distinct.where('expires_date_ms < ?', Time.now)
                         .where(is_trial_period: true).find_each do |user|
                            response = send_data_to_apple(user)
                            apple_data = DataAgregatorService.new(response)
                            user.update(product_id: apple_data.parsed_data[:product_id],
                                        application_version: apple_data.parsed_data[:application_version],
                                        is_trial_period: apple_data.parsed_data[:is_trial_period],
                                        expires_date_ms: apple_data.parsed_data[:expires_date_ms],
                                        latest_receipt: apple_data.parsed_data[:latest_receipt])
    end
  end

  def send_data_to_apple(user)
    # sandbox_verify_receipt_url
    verify_receipt_url = "#{Rails.application.credentials.dig(:apple, :verify_receipt_url)}"
    password = "#{Rails.application.credentials.dig(:apple, :password)}"
    params = { 'receipt-data' => user.latest_receipt, 'password' => password }
    HTTParty.post(verify_receipt_url, body: params.to_json, headers: headers)
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end
end
