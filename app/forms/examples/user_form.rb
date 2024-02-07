
class Examples::UserForm < ApplicationForm
  attribute :firstname, :string
  attribute :lastname, :string
  attribute :salary, MoneyType.new
  attribute :framework, :string
  attribute :check_box_test, :string
  attribute :check_box_test2, :string
  attribute :check_box_test3, :string
  attribute :accept, :boolean
  attribute :accept2, :boolean, default: false
  attribute :tags, CustomArrayType.new
  
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :framework, presence: true
  validates :accept2, acceptance: { accept: true, message: 'must be accepted 2' }
  validates :accept, presence: { message: "Custom error message accept me." }
  validates :salary, comparison: { less_than: 1000 }

  TAGS = %i[wifi animals parking sea_view]

  def save
    return unless valid?
  end
end