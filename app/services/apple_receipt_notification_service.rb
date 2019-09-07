class AppleReceiptNotificationService
  def initialize(receipt_data, sandbox)
    @receipt_data = receipt_data
    @sandbox = sandbox
    @verify_receipt_url = "#{Rails.application.credentials.dig(:apple, :verify_receipt_url)}"
    @sandbox_verify_receipt_url = "#{Rails.application.credentials.dig(:apple, :sandbox_verify_receipt_url)}"
    @password = "#{Rails.application.credentials.dig(:apple, :password)}"
    @params = { 'receipt-data' => @receipt_data, 'password' => @password }
  end

  def call
    if @sandbox == true
      HTTParty.post(@sandbox_verify_receipt_url, body: @params.to_json, headers: headers)
    else
      HTTParty.post(@verify_receipt_url, body: @params.to_json, headers: headers)
    end
  end

  private

  def headers
    { 'Content-Type' => 'application/json' }
  end
end
