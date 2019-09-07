class AppsflyerService
  def initialize(params)
    @params = params
    @appsflyer_id = params[:appsflyer_id]
    @currency = params[:currency]
    @event_name = params[:event_key]
    @url = Rails.application.credentials.dig(:appsflyer, :url)
    @dev_key = Rails.application.credentials.dig(:appsflyer, :dev_key)
  end

  def call
    HTTParty.post(@url, body: { appsflyer_id: @appsflyer_id, eventValue: @params.to_json, eventName: @event_name, af_currency: @currency, af_events_api: 'true' }.to_json, headers: headers)
  end

  private

  def headers
    { 'Authentication' => "#{@dev_key}", 'Content-Type' => 'application/json' }
  end
end

# require 'appsflyer_service.rb'
# u = UserPurchase.last
# p = Purchase.last
# params = { appsflyer_id: u.appsflyer_id, eventValue: p.currency_amount, currency: p.currency }
# params = { appsflyer_id: u.appsflyer_id, af_revenue: p.currency_amount, af_currency: p.currency, user_id: u.id, currency: p.currency }
