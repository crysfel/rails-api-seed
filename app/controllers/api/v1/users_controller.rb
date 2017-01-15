
module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_request!
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    # Shows the list of users
    def index
      authorize User
      @users = User.all

      render json: @users
    end

    # GET /users/1
    # Shows a single user
    def show
      authorize @user
      render json: @user
    end

    # POST /users
    # Admin is the one who will use this method to create new users
    # from the administration panel
    def create
      authorize User
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      authorize @user
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      authorize User
      @user.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
  end
end
