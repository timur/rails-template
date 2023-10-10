class UserForm < ApplicationForm
  attribute :firstname, :string
  attribute :lastname, :string
  validates :firstname, presence: true
  validates :lastname, presence: true

  def save
    return unless valid?
  end
end