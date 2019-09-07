class DataAgregatorService
  def initialize(response)
    @response = response.body
  end

  def extract_main_data
    JSON.parse(@response)&.dig('latest_receipt_info')[0]
  end

  def extract_additional_data
    JSON.parse(@response)&.dig('receipt')&.dig('application_version')
  end

  def extract_receipt
    JSON.parse(@response)&.dig('latest_receipt')
  end

  def parsed_data
    { product_id: extract_main_data&.dig('product_id'),
      is_trial_period: extract_main_data&.dig('is_trial_period'),
      expires_date_ms: Time.at(extract_main_data&.dig('expires_date_ms').to_i/1000),
      application_version: extract_additional_data,
      latest_receipt: extract_receipt
    }
  end
end
