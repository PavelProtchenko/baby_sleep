module Api
  module V1
    class ApiController < ApplicationController
      before_action :restrict_access

      protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

      private

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end
    end
  end
end
