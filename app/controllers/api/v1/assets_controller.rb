
module Api::V1
  class AssetsController < ApplicationController
    before_action :authenticate_request!
    before_action :set_asset, only: [:show, :update, :destroy]

    # GET /assets
    def index
      if current_user.admin
        @assets = Asset.all
      else
        @assets = current_user.assets
      end

      render json: @assets
    end

    # GET /assets/1
    def show
      authorize @asset
      render json: @asset
    end

    # POST /assets
    def create
      authorize Asset
      @asset = Asset.new(asset_params)
      @asset.user_id = current_user.id

      if @asset.save
        render json: @asset, status: :created
      else
        render json: @asset.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /assets/1
    def update
      authorize @asset
      if @asset.update(asset_params)
        render json: @asset
      else
        render json: @asset.errors, status: :unprocessable_entity
      end
    end

    # DELETE /assets/1
    def destroy
      authorize @asset
      @asset.destroy

      render json: { success: true }, state: :ok
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_asset
        @asset = Asset.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def asset_params
        params.require(:asset).permit(:file, :description)
      end
  end
end
