
class Examples::FieldsForm < ApplicationForm

  def save
    return unless valid?
  end
end