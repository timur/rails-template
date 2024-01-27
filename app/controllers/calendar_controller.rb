class CalendarController < ApplicationController
  include CalendarActions

  # custom route for month picker
  def custom
    events = []
    month_date = params[:month_date] ? Date.parse(params[:month_date]) : Date.today
    options = params.merge({ events: events, month_date: month_date})
    id = params[:id]

    respond_to do |format|      
      format.turbo_stream {
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/calendar/month_calendar", locals: { options: })}
    end
  end

end
