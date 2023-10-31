class CalendarController < ApplicationController

  def index
    id = params[:id] ? params[:id] : "calendar"
    date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/month_calendar", locals: { date: date, id: id}) }
    end
  end

  def year
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
