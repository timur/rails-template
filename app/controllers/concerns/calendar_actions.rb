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
          turbo_stream.update(id, partial: "shared/month_calendar", locals: { options: month_calendar_options })}
    end
  end   

  private
  def month_calendar_options
    events = []
    month_date = params[:month_date] ? Date.parse(params[:month_date]) : Date.today
    params.merge({ events: events, month_date: month_date})
  end
end