#Rails.application.config.active_storage.analyzers.prepend ActiveStorage::Analyzer::ImageAnalyzer::Vips
#Rails.application.config.active_storage.analyzers.prepend ActiveStorage::Analyzer::ImageAnalyzer::Imagekit

Rails.application.configure do
  config.after_initialize do
    config.active_storage.analyzers.prepend ActiveStorage::Analyzer::ImageAnalyzer::Imagekit
  end
end