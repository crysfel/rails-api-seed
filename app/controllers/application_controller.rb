class ApplicationController < ActionController::API
  require 'json_webtoken'
  include ActionController::Serialization
  include Pundit

  # Whenever there's unauthorized access to any of the actions
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  protected
    # Validates the token and user and sets the @current_user scope
    def authenticate_request!
      if !payload || !JsonWebToken.valid_payload(payload.first)
        return invalid_authentication
      end

      load_current_user!
      invalid_authentication unless @current_user
    end

    # Returns 401 response. To handle malformed / invalid requests.
    def invalid_authentication
      render json: { error: 'Invalid Request' }, status: :unauthorized
    end

  private
    # Deconstructs the Authorization header and decodes the JWT token.
    def payload
      auth_header = request.headers['Authorization']
      token = auth_header.split(' ').last
      JsonWebToken.decode(token)
    rescue
      nil
    end

    # Sets the @current_user with the user_id from payload
    def load_current_user!
      @current_user = User.find_by(id: payload[0]['user_id'])
    end

    # Getting the current authenticated user
    def current_user
      @current_user
    end

    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore
      render json: { error: "User does not have access to this resource: #{policy_name}.#{exception.query}" }, status: :unauthorized
    end

    def resource_not_found(exception)
        render json: { error: 'Resource not found' }, status: :not_found
    end
end
