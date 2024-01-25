class CalendarController < ApplicationController

  def index
  end

  # GET /calendar/month_picker
  # standard route for month picker
  def month_picker
    events = []
    events << OpenStruct.new(title: "Der Name meines Events", date: Date.today + 3.days, color: "bg-green-500/70", url: dashboard_path)
    events << OpenStruct.new(title: "Noch ein tolles Event", date: Date.today + 10.days, color: "bg-blue-500", url: dashboard_path)

    date = params[:date] ? Date.parse(params[:date]) : Date.today
    options = params.merge({ events: events, date: date })
    id = params[:id]

    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/month_calendar", locals: { options: })}
    end
  end  

  # custom route for month picker
  def custom
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    options = params.merge({ events: [], date: date })
    id = params[:id]

    respond_to do |format|      
      format.turbo_stream {
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/month_calendar", locals: { options: })}
    end
  end

  def datepicker_paginate
    id = params[:id] ? params[:id] : "calendar"
    date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/datepicker_month", locals: { date: date, id: id}) }
    end
  end

  def year
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = []
    @events << OpenStruct.new(title: "Der Name meines Events", date: Date.today + 3.days, color: "bg-green-500")
    @events << OpenStruct.new(title: "Noch ein tolles Event", date: Date.today + 10.days, color: "bg-blue-500")
  end

  def datepicker
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @form = DatepickerForm.new
  end

end
