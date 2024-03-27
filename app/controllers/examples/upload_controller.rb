module Examples
  class UploadController < ApplicationController
    def new
      picture_imagekit_urls
    end

    def reorder
      @service = ImagekitService.new
      @pictures = Picture.rank(:picture_order).all
    end

    def patch_reorder
      @picture = Picture.find(params[:id])
      @picture.update(picture_order_position: params[:picture_order])
    end

    def glitch
      imagekit_service = ImagekitService.new
      @picture_data = imagekit_service.picture_data
    end

    def picture
    end

    def create
      imagekit_service = ImagekitService.new
      picture = Picture.new(picture_params)
      picture.image.attach(params[:signed_blob_id])
      if picture.save
        render json: {
          id: picture.id,
          thumb: imagekit_service.thumb_url(picture.image),
          large: imagekit_service.large_url(picture.image),
        }, status: :created
      end
    end

    private

    def picture_params
      params.require(:picture).permit(:name)
    end

  end
end