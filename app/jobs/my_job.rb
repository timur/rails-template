class MyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info "MyJob is performing"
  end
end
