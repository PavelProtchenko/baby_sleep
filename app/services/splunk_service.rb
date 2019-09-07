class SplunkService
  def initialize(params)
    @params = params
    @source = 'BabySleep_CommonData'
    @sourcetype = 'Server'
    @url = "#{Rails.application.credentials.dig(:splunk, :url)}/services/collector"
    @token = Rails.application.credentials.dig(:splunk, :token)
  end

  def call
    HTTParty.post(@url, body: { event: @params, source: @source, sourcetype: @sourcetype }.to_json, headers: headers)
  end

  private

  def headers
    { 'Authorization' => "Splunk #{@token}", 'Content-Type' => 'application/json' }
  end
end
