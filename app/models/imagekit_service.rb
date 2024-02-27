class ImagekitService
  def initialize
    @imagekitio = ImageKitIo::Client.new(
      Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PRIVATE),
      Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PUBLIC),
      'https://ik.imagekit.io/ojynjrt2uct/wasabi/'
    )
  end

  def thumb_url(blob)
    @imagekitio.url(transform_options(blob, "800"))
  end

  def imagekit
    @imagekitio
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
