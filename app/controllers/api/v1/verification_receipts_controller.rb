module Api
  module V1
    class VerificationReceiptsController < Api::V1::ApiController
      skip_before_action :verify_authenticity_token, only: :create
      def create
        @verificator = UserPurchase.create!(appsflyer_id: verification_params[:appsflyer_id],
                                            product_id: verification_purchase_params[:product_id],
                                            receipt: verification_params[:receipt],
                                            store: verification_purchase_params[:store],
                                            event_key: verification_purchase_params[:event_key])

        verificator_purchase = Purchase.new(product_id: verification_purchase_params[:product_id],
                                            store: verification_purchase_params[:store],
                                            currency: verification_purchase_params[:currency],
                                            currency_amount: verification_purchase_params[:currency_amount])

          verificator_purchase.save

          # Save data to Purchase
          @receipt_data = verification_params[:receipt]
          @revenue = verification_purchase_params[:currency_amount]
          # @sandbox = verification_params[:sandbox]
          @verify_receipt_url = "#{Rails.application.credentials.dig(:apple, :verify_receipt_url)}"
          @sandbox_verify_receipt_url = "#{Rails.application.credentials.dig(:apple, :sandbox_verify_receipt_url)}"
          @password = "#{Rails.application.credentials.dig(:apple, :password)}"
          @params = { 'receipt-data' => @receipt_data, 'password' => @password }
          trial_params_appsflyer = { af_currency: verification_purchase_params[:currency] }
          params_appsflyer = { af_revenue: @revenue, af_currency: verification_purchase_params[:currency] }

          # Parse parameters from http response
          response = HTTParty.post(@verify_receipt_url, body: @params.to_json, headers: headers)

          # Data agregation service
          apple_data = DataAgregatorService.new(response)
          @verificator.update(product_id: apple_data.parsed_data[:product_id],
                              application_version: apple_data.parsed_data[:application_version],
                              is_trial_period: apple_data.parsed_data[:is_trial_period],
                              expires_date_ms: apple_data.parsed_data[:expires_date_ms],
                              latest_receipt: apple_data.parsed_data[:latest_receipt])

          first_trial_params = { event_key: verification_purchase_params[:event_key] + '_DidSuccessPurchase',
                                    store: verification_purchase_params[:store],
                                    currency: verification_purchase_params[:currency],
                                    product_id: verification_purchase_params[:product_id]
                                }

          # first_purchase_params = { event_key: verification_purchase_params[:event_key] + '_DidSuccessPurchase',
          #                           currency_amount: verification_purchase_params[:currency_amount] * 0.7,
          #                           store: verification_purchase_params[:store],
          #                           currency: verification_purchase_params[:currency],
          #                           product_id: verification_purchase_params[:product_id]
          #                         }

          AppsflyerService.new(verification_params.merge(trial_params_appsflyer).merge(first_trial_params)).call
          SplunkService.new(verification_params.merge(trial_params_appsflyer).merge(first_trial_params)).call
          # AppsflyerService.new(verification_params.merge(params_appsflyer).merge(first_purchase_params)).call
        # end
        # else
          puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nNo verification purchase params"
        # end

        # verificator = UserReceiptsVerificator.new(current_user, verification_params)
        @verificator = verification_params
        if @verificator
          render json: { valid: @verificator }, status: 200
        else
          render json: { message: 'Invalid receipt' }, status: 422
        end
      end

      private

      def headers
        { 'Content-Type' => 'application/json' }
      end

      def verification_params
        params.permit(:receipt, :appsflyer_id, :sandbox)
      end

      def verification_purchase_params
        params.permit(:store, :currency, :currency_amount, :event_key, :product_id)
      end
    end
  end
end
