module API
  module V1
    module Defaults
      # if you're using Grape outside of Rails, you'll have to use Module#included hook
      extend ActiveSupport::Concern

      included do
        use ActionDispatch::RemoteIp
        # common Grape settings
        version 'v1'
        format :json

        # global handler for simple not found case
        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error_response(message: e.message, status: 422)
        end

        # global exception handler, used for error notifications
        rescue_from :all do |e|
          if Rails.env.development?
            raise e
          else
            Raven.capture_exception(e)
            error_response(message: "Internal server error", status: 500)
          end
        end

        # HTTP header based authentication
        before do
          # error!('Unauthorized', 401) unless headers['Authorization'] == "some token"
        end

        helpers do
          def client_ip
            env["action_dispatch.remote_ip"].to_s
          end
        end
      end
    end
  end
end
