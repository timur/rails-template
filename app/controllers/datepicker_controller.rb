class DatepickerController < ApplicationController

  def create
    Rails.logger.info "DatepickerController#create"
    @form = DatepickerForm.new_with_permitted_params(params)
    respond_to do |format|
      if @form.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              'new_form',
              partial: "calendarda/datepicker_form",
              locals: { form: DatepickerForm.new }),
            ]
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              'new_form',
              partial: "calendar/datepicker_form",
              locals: { form: @form })
            ]
        end
      end
    end
  end
end
