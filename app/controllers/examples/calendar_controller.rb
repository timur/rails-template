class Examples::CalendarController < ApplicationController

  def index
  end

  def datepicker
    @form = Examples::DatepickerForm.new    
  end

  def datepicker_create
    @form = Examples::DatepickerForm.new_with_permitted_params(params)
    respond_to do |format|
      if @form.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              'new_form',
              partial: "examples/calendar/datepicker_form",
              locals: { form: Examples::DatepickerForm.new }),
            ]
        end
      else
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
