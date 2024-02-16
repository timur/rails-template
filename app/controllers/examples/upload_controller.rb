module Examples
  class UploadController < ApplicationController
    def new
    end

    def create
      @picture = Picture.new(picture_params)
      @picture.image.attach(params[:signed_blob_id])
      if @picture.save
        render json: @picture, status: :created
      end
    end

    private

    def picture_params
      params.require(:picture).permit(:name)
    end
  end
end