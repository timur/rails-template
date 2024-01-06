module CalendarHelper

  def compact_month_calendar(options = {})
    date = options[:date] || Date.today
    navigation = options.key?(:navigation) ? options[:navigation] : true
    param = options[:param] || :date
    id = options.key?(:id) ? options[:id] : :calendar

    render partial: "calendar/compact_month_calendar", locals: {
      date:,
      navigation:,
      param:,
      id:
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
      in_current_month: is_in_current_month?(day),
      is_first_in_month_range: first_day_of_month_range(whole_month_range(date), day),
      is_last_in_month_range: last_day_of_month_range(whole_month_range(date), day),
      is_last_day_of_first_week: last_day_of_first_week(date, day),
      is_first_day_of_last_week: first_day_of_last_week(date, day)
    )
  end

  def calendar_cell_inside_classes(date, day)
    TailwindClasses.calendar_cell_inside.render(
      today: is_today?(day)
    )
  end  

  def is_today?(day)
    Date.today === day
  end

  def is_in_current_month?(day)
    Date.today.all_month.cover? day
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
