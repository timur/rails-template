class CalendarController < ApplicationController

  def index
    id = params[:id] ? params[:id] : "calendar"
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    events = []
    events << OpenStruct.new(title: "Der Name meines Events", date_time: DateTime.parse("20.01.2024 17:33"), url: dashboard_path, color: "bg-green-500/70")
    events << OpenStruct.new(title: "Noch ein tolles Event", date_time: DateTime.parse("05.01.2024 12:33"), url: dashboard_path, color: "bg-red-500/70")

    respond_to do |format|
      format.html {
        render locals: { date:, id:, events: }
      } 
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/month_calendar", locals: { date:, id:, events: }) }
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
    @events << OpenStruct.new(title: "Der Name meines Events", date_time: DateTime.parse("20.01.2024 17:33"), url: dashboard_path, color: "bg-green-500/70")
    @events << OpenStruct.new(title: "Noch ein tolles Event", date_time: DateTime.parse("05.01.2024 12:33"), url: dashboard_path, color: "bg-red-500/70")
  end

  def month
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = []
    @events << OpenStruct.new(title: "Der Name meines Events", date_time: DateTime.parse("20.01.2024 17:33"), url: dashboard_path, color: "bg-green-500/70")
    @events << OpenStruct.new(title: "Noch ein tolles Event", date_time: DateTime.parse("05.01.2024 12:33"), url: dashboard_path, color: "bg-red-500/70")
  end
  
  def week
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = []
    @events << OpenStruct.new(title: "Der Name meines Events", date_time: DateTime.parse("20.01.2024 17:33"), url: dashboard_path, color: "bg-green-500/70")
    @events << OpenStruct.new(title: "Noch ein tolles Event", date_time: DateTime.parse("05.01.2024 12:33"), url: dashboard_path, color: "bg-red-500/70")
  end  

  def datepicker
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @form = DatepickerForm.new
  end

end
