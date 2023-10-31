require "tailwind_merge"

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

  def year_view_classes(calendar_date, date)
    classes = %w(py-1.5 hover:bg-gray-100 focus:z-10)
    # is in month
    classes.push(%w(bg-white text-gray-900)) if month_range(calendar_date).cover?(date)
    classes.push(%w(bg-gray-50 text-gray-400)) unless month_range(calendar_date).cover?(date)
    classes.push(%w(rounded-tl-lg)) if whole_range(calendar_date).to_a.first === date
    classes.push(%w(rounded-br-lg)) if whole_range(calendar_date).to_a.last === date
    classes.push(%w(rounded-tr-lg)) if last_day_week(calendar_date.beginning_of_month) === date
    classes.push(%w(rounded-bl-lg)) if first_day_week(calendar_date.end_of_month) === date
    classes
  end

  def year_view_time_classes(calendar_date, date)
    classes = %w(mx-auto flex h-7 w-7 items-center justify-center rounded-full)
    classes.push(%w(bg-indigo-600 font-semibold text-white)) if date === Date.today
    classes
  end

  def month_range date
    date.beginning_of_month..date.end_of_month
  end

  def whole_range date
    date.beginning_of_month.beginning_of_week(:monday)..date.end_of_month.end_of_week(:monday)
  end

  def last_day_week date
    date.end_of_week(:monday)
  end

  def first_day_week date
    date.beginning_of_week(:monday)
  end

  def date_range(date)
    (date.beginning_of_month.beginning_of_week(:monday)..date.end_of_month.end_of_week(:monday)).to_a
  end
end
