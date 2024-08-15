class EmailForm < ApplicationForm
  attribute :email, :string
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def save
    valid?
  end
end