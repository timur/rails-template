module CalendarHelper

  # Renders a compact month calendar.
  #
  # @param [Hash] options The options for setting the date.
  # @option options [Date] :date The date to be set (default: Date.today).
  # @option options [Boolean] :navigation Whether to show navigation (default: true).
  # @option options [Symbol] :param The param to be set (default: :date).
  # @option options [Symbol] :id The id of the calendar (default: :calendar).
  # @option options [Array] :events The events to be shown (default: []).
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
    events.find { |e| e.date == day }
  end

  def calendar_cell_inside_classes(date, day, events = [])
    classes = []
    classes << is_today_classes(date, day)
    classes << has_event?(day, events)
    classes
  end

  def is_today?(day)
    Date.today === day
  end

  def is_in_month?(date, day)
    date.all_month.cover? day
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
end
