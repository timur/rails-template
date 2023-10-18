
class FieldsForm < ApplicationForm

  def save
    return unless valid?
  end
end