class PasswordForm < ApplicationForm
  attribute :password, :string
  attribute :password_confirmation, :string
  
  validates :password, presence: true, length: { minimum: 12 }, confirmation: true
  validates :password_confirmation, presence: true

  def save
    valid?
  end
end