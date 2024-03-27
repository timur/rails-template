module CalendarHelper

  # Renders a compact month calendar.
  #
  # @param [Hash] options The options for setting the date.
  # @option options [Date] :month_date The date to be set (default: Date.today).
  # @option options [Boolean] :navigation Whether to show navigation (default: true).
  # @option options [Symbol] :param The param to be set (default: :date).
  # @option options [Symbol] :id The id of the calendar (default: :calendar).
  # @option options [Array] :events The events to be shown (default: []).
  # @option options [Date] :marked_date The date to be marked (default: nil).
  # @option options [String] :route The route to be used (default: "calendar_month_picker_path").
  def compact_month_calendar(options = {})
    date = options[:date] || Date.today
    navigation = options.key?(:navigation) ? options[:navigation] : true
    param = options[:param] || :month_date
    id = options[:id] || SecureRandom.random_number(10000000)
    events = options[:events] || []
    route = options[:route] || "calendar_month_picker_path"

    render partial: "calendar/compact_month_calendar", locals: {
      month_date:,
      navigation:,
      param:,
      id:,
      events:,
      route:
    }
  end

  # Renders a compact month for a datepicker calendar.
  #
  def datepicker_month_calendar(options = {})
    month_date = options[:month_date] || Date.today
    current_date = options[:current_date] || nil
    param = options[:param] || :month_date
    id = options[:id] || SecureRandom.random_number(10000000)
    events = options[:events] || []
    route = options[:route] || "calendar_month_picker_path"

    if current_date.present?
      events << OpenStruct.new(title: "", date: current_date, color: "bg-green-500")
    end

    render partial: "calendar/datepicker_month", locals: {
      month_date:,
      current_date:,
      param:,
      id:,
      events:,
      route:
    }
  end  

  # Renders a year view calendar
  #
  # @param [Hash] options The options for setting the date.
  # @option options [Date] :year_date The date to be set (default: Date.today).
  # @option options [Array] :events The events to be shown (default: []).
  # @option options [String] :route The route to be used (default: "calendar_month_picker_path").
  def year_calendar(options = {})
    year_date = options[:year_date] || Date.today
    events = options[:events] || []

    render partial: "calendar/year_calendar", locals: {
      year_date:,
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

  def is_in_week?(date, day)
    (date.beginning_of_week(:monday)..date.end_of_week(:monday)).cover? day
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

  def week_event_classes(start_date, end_date)
    wday = wday_for_date(start_date)
    duration = duration(start_date, end_date)
    start_number = beginning_week_number(start_date)

    style = "grid-row: #{start_number.to_i} / span #{(duration * 12).to_i}"

    case wday
    when 1
      ["relative mt-px flex sm:col-start-1", style]
    when 2
      ["relative mt-px flex sm:col-start-2", style]
    when 3
      ["relative mt-px flex sm:col-start-3", style]
    when 4
      ["relative mt-px flex sm:col-start-4", style]
    when 5
      ["relative mt-px flex sm:col-start-5", style]
    when 6
      ["relative mt-px flex sm:col-start-6", style]
    when 7
      ["relative mt-px flex sm:col-start-7", style]
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

  def wday_for_date(date)
    return 7 if date.wday == 0
    date.wday
  end

  def duration(start_date, end_date)
    (end_date.to_time - start_date.to_time) / 1.hour
  end

  def beginning_week_number(start_date)
    padding = 2
    duration = duration(start_date.beginning_of_day, start_date)
    (duration * 12) + padding
  end
end
