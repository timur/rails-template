module ActiveStorage
  class Analyzer::ImageAnalyzer::Imagekit < Analyzer::ImageAnalyzer

    def self.accept?(blob)
      blob.image?
    end

    def metadata
      service = ImagekitService.new
      url = service.thumb_url(blob)
      response = service.imagekit.get_remote_file_url_metadata(
        remote_file_url: url
      )
      Rails.logger.info("ImagekitAnalyzer#metadata #{response.keys.inspect}")
      Rails.logger.info("ImagekitAnalyzer#metadata #{response[:response]}")
      response[:response]
    end

  end
end