SubmenuEntry = Struct.new(:text, :url)

# ImageKitIo.configure do |config|
#   if Rails.env.development?
#     config.public_key = Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PUBLIC)
#     config.private_key = Rails.application.credentials.dig(:imagekit, :IMAGEKIT_PRIVATE)
#     config.url_endpoint = 'https://ik.imagekit.io/ojynjrt2uct/wasabi/'
#   end
#   config.service = :active_storage
# end