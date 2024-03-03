module Examples
  class UploadController < ApplicationController
    def new
      picture_imagekit_urls
    end

    def glitch
      picture_imagekit_urls
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

    def picture_imagekit_urls
      @picture_imagekit_urls = []
      imagekitio = ImageKitIo::Client.new(
        Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PRIVATE),
        Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PUBLIC),
        #'https://ik.imagekit.io/ojynjrt2uct/wasabi/'
        'https://ik.imagekit.io/ojynjrt2uct/cloudflare/'
      )
      pictures = Picture.with_attached_image.order(created_at: :desc)
      pictures.each do |picture|
        urls = OpenStruct.new
        urls.thumb = imagekitio.url({
          path: "/#{picture.image.key}",
          transformation: [{
            height: "800"
          }],
          signed: true,
          expire_seconds: 300
        })
        urls.large = imagekitio.url({
          path: "/#{picture.image.key}",
          transformation: [{
            height: "1200"
          }],
          signed: true,
          expire_seconds: 300
        })
        urls.width = picture.image.metadata[:width]  
        urls.height = picture.image.metadata[:height]  
        @picture_imagekit_urls << urls
      end
    end
  end
end