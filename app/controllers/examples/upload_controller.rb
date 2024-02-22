module Examples
  class UploadController < ApplicationController
    def new
      @picture_imagekit_urls = []
      imagekitio = ImageKitIo::Client.new(
        Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PRIVATE),
        Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PUBLIC),
        'https://ik.imagekit.io/ojynjrt2uct/wasabi/'
      )
      pictures = Picture.all
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
        @picture_imagekit_urls << urls
      end
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