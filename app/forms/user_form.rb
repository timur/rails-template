ActiveRecord::Type.register(:money, MoneyType)
class UserForm < ApplicationForm
  attribute :firstname, :string
  attribute :lastname, :string
  attribute :salary, MoneyType.new
  
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :salary, comparison: { less_than: 1000 }

  def save
    return unless valid?
  end
end