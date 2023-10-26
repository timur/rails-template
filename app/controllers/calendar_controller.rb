class CalendarController < ApplicationController

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def year
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
