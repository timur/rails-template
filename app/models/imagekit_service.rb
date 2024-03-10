class ImagekitService
  def initialize
    @imagekitio = ImageKitIo::Client.new(
      Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PRIVATE),
      Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PUBLIC),
      'https://ik.imagekit.io/ojynjrt2uct/cloudflare/'
    )
  end

  def thumb_url(blob)
    @imagekitio.url(transform_options(blob, "800"))
  end

  def large_url(blob)
    @imagekitio.url(transform_options(blob, "1200"))
  end

  def imagekit
    @imagekitio
  end

  def picture_data_slim
    picture_data = OpenStruct.new
    picture_data.selected_count = Picture.with_attached_image.where(selected: true).count

    picture_data
  end

  def picture_data
    picture_data = OpenStruct.new
    pictures = Picture.with_attached_image.order(created_at: :desc)

    picture_data.selected_count = pictures.where(selected: true).count
    picture_data.pictures = []

    pictures.each do |picture|
      data = OpenStruct.new
      data.thumb = thumb_url(picture.image)
      data.large = thumb_url(picture.image)
      data.width = picture.image.metadata[:width]  
      data.height = picture.image.metadata[:height] 
      data.picture = picture
      picture_data.pictures << data
    end
    picture_data
  end

  def data_for_picture(picture)
    data = OpenStruct.new
    data.thumb = thumb_url(picture.image)
    data.large = thumb_url(picture.image)
    data.width = picture.image.metadata[:width]  
    data.height = picture.image.metadata[:height] 
    data.picture = picture
    data
  end

  def data_for_picture_alternate(picture, width, height)
    data = OpenStruct.new
    data.thumb = thumb_url(picture.image)
    data.large = thumb_url(picture.image)
    data.width = width
    data.height = height
    data.picture = picture
    data
  end  

  private

  def transform_options(blob, height)
    {
      path: "/#{blob.key}",
      transformation: [{ height: height }],
      signed: true,
      expire_seconds: 300
    }
  end
end
