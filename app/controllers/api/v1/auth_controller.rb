
module Api::V1
  class AuthController < ApplicationController

    # POST /v1/auth
    # Sign up from app or website
    def create
      @user = User.new(user_params)

      if @user.save
        # @TODO Invoke send email method here

        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # GET /v1/confirm
    # Confirms the token/email and updates the user record on database
    def confirm
      token = params[:token].to_s

      user = User.find_by(confirmation_token: token)

      if user.present? && user.confirmation_token_valid?
        user.mark_as_confirmed!
        render json: { status: "User confirmed successfully" }, status: :ok
      else
        render json: { status: "Invalid token" }, status: :not_found
      end
    end

    # POST /v1/login
    # Login the user into the system
    def login
      user = User.find_by(email: params[:email].to_s.downcase)

      if user && user.authenticate(params[:password])
        auth_token = JsonWebToken.encode({ user_id: user.id })
        render json: { token: auth_token }, status: :authorized
      else
        render json: { error: 'Invalid username / password' }, status: :unauthorized
      end
    end

    private
      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
  end
end
