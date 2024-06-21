class GmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TestMailer.test.deliver_now
  end
end
