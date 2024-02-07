
class Examples::DatepickerForm < ApplicationForm
  attribute :birthdate, :date
  attribute :prefilled_date, :date, default: Date.today + 25.days

  validates :birthdate, presence: { message: "Bitte gib ein Geburtsdatum ein." }

  def save
    return unless valid?
  end
end