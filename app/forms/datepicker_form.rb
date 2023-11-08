
class DatepickerForm < ApplicationForm
  attribute :birthdate, :date

  validates :birthdate, presence: { message: "Bitte gib ein Geburtsdatum ein." }

  def save
    return unless valid?
  end
end