class CalendarController < ApplicationController

  def index
    @date = params[:date] || Date.today
    @start_date = @date.beginning_of_month.beginning_of_week(:monday)
    @end_date = @date.end_of_month.end_of_week(:monday)
    @date_range = (@start_date..@end_date).to_a
  end
end
