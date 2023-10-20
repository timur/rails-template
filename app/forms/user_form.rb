
class UserForm < ApplicationForm
  attribute :firstname, :string
  attribute :lastname, :string
  attribute :salary, MoneyType.new
  attribute :framework, :string
  attribute :check_box_test, :string
  attribute :check_box_test2, :string
  attribute :check_box_test3, :string
  attribute :tags, CustomArrayType.new
  
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :framework, presence: true
  validates :salary, comparison: { less_than: 1000 }

  TAGS = %i[wifi animals parking sea_view]

  def save
    return unless valid?
  end
end