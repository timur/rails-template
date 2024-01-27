module CalendarActions
  extend ActiveSupport::Concern

  included do
    include ActionView::RecordIdentifier
  end

  def month_picker
    id = params[:id]

    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/calendar/month_calendar", locals: { options: month_calendar_options })}
    end
  end 
  
  def datepicker
    id = params[:id]

    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/calendar/month_calendar", locals: { options: datepicker_options })}
    end
  end

  def year
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update("calendar", partial: "shared/calendar/year_calendar", locals: { options: year_calendar_options })}
    end
  end

  private

  def month_calendar_options
    events = []
    month_date = params[:month_date] ? Date.parse(params[:month_date]) : Date.today
    params.merge({ events: events, month_date: month_date})
  end

  def year_calendar_options
    events = []
    year_date = params[:year_date] ? Date.parse(params[:year_date]) : Date.today
    params.merge({ events: events, year_date: year_date})
  end  

  def datepicker_options
    month_calendar_options.merge({ datepicker: true })
  end
end