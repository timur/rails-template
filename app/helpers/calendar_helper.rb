module CalendarHelper

  def compact_month_calendar(options = {})
    date = options[:date] || Date.today
    navigation = options.key?(:navigation) ? options[:navigation] : true
    param = options[:param] || :date
    id = options.key?(:id) ? options[:id] : :calendar
    events = options[:events] || []

    render partial: "calendar/compact_month_calendar", locals: {
      date:,
      navigation:,
      param:,
      id:,
      events:
    }
  end

  # Month calendar big view
  def month_calendar(options = {})
    date = options[:date] || Date.today
    events = options[:events] || []
    render partial: "calendar/month_calendar", locals: {
      date:,
      events:
    }    
  end

  # Week calendar
  def week_calendar(options = {})
    date = options[:date] || Date.today
    events = options[:events] || []
    render partial: "calendar/week_calendar", locals: {
      date:,
      events:
    }    
  end  

  # Renders datepicker
  def datepicker_month(options = {})
    date = options[:date] || Date.today
    navigation = options.key?(:navigation) ? options[:navigation] : true
    param = options[:param] || :date
    id = options.key?(:id) ? options[:id] : :calendar

    render partial: "calendar/datepicker", locals: {
      date:,
      navigation:,
      param:,
      id:
    }
  end

  def calendar_cell_classes(date, day)
    TailwindClasses.calendar_cell.render(
      in_current_month: is_in_month?(date, day),
      is_first_in_month_range: first_day_of_month_range(whole_month_range(date), day),
      is_last_in_month_range: last_day_of_month_range(whole_month_range(date), day),
      is_last_day_of_first_week: last_day_of_first_week(date, day),
      is_first_day_of_last_week: first_day_of_last_week(date, day)
    )
  end

  def calendar_cell_month_classes(date, day)
    TailwindClasses.calendar_cell_month.render(
      in_current_month: is_in_month?(date, day)
    )
  end  

  def calendar_time_month_classes(date, day)
    TailwindClasses.calendar_time_month.render(
      today: is_today?(day)
    )
  end    

  def is_today_classes(date, day)
    if is_today?(day)
      TailwindClasses.calendar_cell_inside.render(
        today: true
      )
    end
  end

  def has_event?(day, events)
    if events.length > 0
      event = find_event(day, events)
      unless event.nil?
        r = TailwindClasses.calendar_cell_inside_events.render(
          event: true
        ) + " #{event.color}"
        r
      end
    end
  end

  def find_event(day, events)
    events.find { |e| e.date_time.to_date == day }
  end

  def events_for_day(day, events)
    events.select { |e| e.date_time.to_date == day }
  end

  def calendar_cell_inside_classes(date, day, events = [])
    classes = []
    classes << is_today_classes(date, day)
    classes << has_event?(day, events)
    classes
  end

  def calendar_week_header_classes(date, day)
    TailwindClasses.calendar_week_header.render(
      today: is_today?(day)
    )
  end
  
  def calendar_week_header_span_classes(date, day)
    TailwindClasses.calendar_week_header_span.render(
      today: is_today?(day)
    )
  end

  def is_today?(day)
    Date.today === day
  end

  def is_in_month?(date, day)
    date.all_month.cover? day
  end

  def grid_rows(date)
    count = whole_month_range(date).count / 7
    case count
    when 5
      "grid-rows-5"
    when 6
      "grid-rows-6"
    when 7
      "grid-rows-7"
    else 
      "grid-rows-6"
    end
  end

  # Returns a range of dates for the beginning of the week of a month and end of a week for the month
  # for example 25.10.2023 - 05.11.2023 this is for November of 2023
  def whole_month_range(date)
    date.beginning_of_month.beginning_of_week(:monday)..date.end_of_month.end_of_week(:monday)
  end  

  def first_day_of_month_range(range, day)
    range.first === day
  end

  def last_day_of_first_week(date, day)
    date.beginning_of_month.end_of_week(:monday) === day
  end

  def first_day_of_last_week(date, day)
    date.end_of_month.beginning_of_week(:monday) === day
  end

  def last_day_of_month_range(range, day)
    range.last === day
  end

  def week_for_day(day)
    day.beginning_of_week(:monday)..day.end_of_week(:monday)
  end
end
