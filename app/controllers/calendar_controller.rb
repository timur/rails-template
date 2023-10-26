class CalendarController < ApplicationController

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @date2 = params[:date2] ? Date.parse(params[:date2]) : Date.today
  end

  def year
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
