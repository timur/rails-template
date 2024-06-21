class TestMailer < ApplicationMailer
  def test
    mail(
      from: "Timur <timur@test.de>",
      to: "tiyalcin@gmail.com", 
      subject: "From app noch mal neu"
    )
  end
end
