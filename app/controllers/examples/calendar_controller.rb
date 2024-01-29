class Examples::CalendarController < ApplicationController

  def index
  end

  def datepicker
    @form = DatepickerForm.new    
  end

  def datepicker_create
    Rails.logger.info "Examples::CalendarController#datepicker_create"
    @form = DatepickerForm.new_with_permitted_params(params)
    respond_to do |format|
      if @form.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              'new_form',
              partial: "examples/calendar/datepicker_form",
              locals: { form: DatepickerForm.new }),
            ]
        end
      else
        Rails.logger.info "Examples::CalendarController#datepicker_create not valid"
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              'new_form',
              partial: "examples/calendar/datepicker_form",
              locals: { form: @form })
            ]
        end
      end
    end    
  end

  def year
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = []
    @events << OpenStruct.new(title: "Der Name meines Events", date: Date.today + 3.days, color: "bg-green-500")
    @events << OpenStruct.new(title: "Noch ein tolles Event", date: Date.today + 10.days, color: "bg-blue-500")
  end
end
