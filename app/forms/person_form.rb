class PersonForm < ApplicationForm
  attribute :name, :string
  attribute :position, :string
  attribute :status, :string
  attribute :portfolio, :string
  attribute :email, :string
  attribute :department, :string
  
  validates :name, presence: true
  validates :email, presence: true

  def save
    valid?
  end
end