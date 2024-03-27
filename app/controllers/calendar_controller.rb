class CalendarController < ApplicationController
  include CalendarHelper

  def index
    id = params[:id] ? params[:id] : "calendar"
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    events = []
    events << OpenStruct.new(title: "Der Name meines Events", date_time: DateTime.parse("20.01.2024 17:33"), url: dashboard_index_path, color: "bg-green-500/70")
    events << OpenStruct.new(title: "Noch ein tolles Event", date_time: DateTime.parse("05.01.2024 12:33"), url: dashboard_index_path, color: "bg-red-500/70")

    respond_to do |format|
      format.html {
        render locals: { date:, id:, events: }
      } 
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/month_calendar", locals: { date:, id:, events: }) }
    end
  end

  # custom route for month picker
  def custom
    events = []
    events << OpenStruct.new(title: "Der Name meines Events", date_time: DateTime.parse("20.01.2024 17:33"), url: dashboard_index_path, color: "bg-green-500/70")
    events << OpenStruct.new(title: "Noch ein tolles Event", date_time: DateTime.parse("05.01.2024 12:33"), url: dashboard_index_path, color: "bg-red-500/70")

    respond_to do |format|
      format.html {
        render locals: { date:, id:, events: }
      } 
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/calendar/month_calendar", locals: { options: })}
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
    @events << OpenStruct.new(title: "Der Name meines Events", date_time: DateTime.parse("20.01.2024 17:33"), url: dashboard_index_path, color: "bg-green-500/70")
    @events << OpenStruct.new(title: "Noch ein tolles Event", date_time: DateTime.parse("05.01.2024 12:33"), url: dashboard_index_path, color: "bg-red-500/70")
  end

  def month
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = []
    @events << OpenStruct.new(title: "Der Name meines Events", date_time: DateTime.parse("20.01.2024 17:33"), url: dashboard_index_path, color: "bg-green-500/70")
    @events << OpenStruct.new(title: "Noch ein tolles Event", date_time: DateTime.parse("05.01.2024 12:33"), url: dashboard_index_path, color: "bg-red-500/70")
  end
  
  def week
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = []
    e = OpenStruct.new(
      title: "Der Name meines Events", 
      start_time: DateTime.parse("20.01.2024 17:00"),
      end_time: DateTime.parse("20.01.2024 20:00"),
      url: dashboard_index_path, color: "bg-green-500/70"
    )
    e1 = OpenStruct.new(
      title: "Noch ein tolles Event", 
      start_time: DateTime.parse("05.01.2024 10:00"),
      end_time: DateTime.parse("05.01.2024 12:00"),
      url: dashboard_index_path, color: "bg-red-500/70"
    )

    e2 = OpenStruct.new(
      title: "Event am Sonntag", 
      start_time: DateTime.parse("14.01.2024 08:00"),
      end_time: DateTime.parse("14.01.2024 10:00"),
      url: dashboard_index_path, color: "bg-red-500/70"
    )    

    @events << e if is_in_week?(e.start_time, @date)
    @events << e1 if is_in_week?(e1.start_time, @date)
    @events << e2 if is_in_week?(e2.start_time, @date)
  end  

  def datepicker
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @form = Examples::DatepickerForm.new  
  end

end
