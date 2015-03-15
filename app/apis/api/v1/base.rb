module API
  module V1
    class Base < Grape::API
      use ActionDispatch::RemoteIp
      # common Grape settings
      prefix :api
      version 'v1', using: :path
      format :json
      formatter :json, Grape::Formatter::Roar

      # global handler for simple not found case
      rescue_from ActiveRecord::RecordNotFound do |e|
        error_response(message: e.message, status: 404)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        error_response(message: e.message, status: 422)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        ap e.record.errors.to_hash(true)
        error_message = []
        e.record.errors.to_hash(true).each do |k, v|
          error_message << {
            field:   k,
            message: v
          }
        end
        error_response(message: { errors: error_message }, status: 422)
      end

      # global exception handler, used for error notifications
      rescue_from :all do |e|
        if Rails.env.development?
          raise e
        else
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

        def permitted_params
          @permitted_params ||= declared(params, include_missing: false)
        end

        def represent(resource, env)
          BaseRepresenter.represent(resource, env)
        end

        def represent_collection(collection, env)
          BaseRepresenter.represent_collection(collection, env)
        end
      end

      mount API::V1::Users
    end
  end
end
