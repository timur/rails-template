class CalendarController < ApplicationController

  def index
    id = params[:id] ? params[:id] : "calendar"
    date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/month_calendar", locals: { date:, id:}) }
    end
  end

  def datepicker_paginate
    id = params[:id] ? params[:id] : "calendar"
    Rails.logger.info "id: #{id}"
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
  end

  def datepicker
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @form = DatepickerForm.new
  end

end
