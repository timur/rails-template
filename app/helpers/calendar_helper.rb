require "tailwind_merge"

module CalendarHelper
  def year_view_classes(calendar_date, date)
    merger = TailwindMerge::Merger.new
    classes = ""
    base_classes = "py-1.5 hover:bg-gray-100 focus:z-10"
    # is in month
    classes = merger.merge("#{base_classes} bg-white text-gray-900") if month_range(calendar_date).cover?(date)
    classes = merger.merge("#{base_classes} #{classes} bg-gray-50 text-gray-400") unless month_range(calendar_date).cover?(date)
    classes = merger.merge("#{classes} rounded-tl-lg") if whole_range(calendar_date).to_a.first === date
    classes = merger.merge("#{classes} rounded-br-lg") if whole_range(calendar_date).to_a.last === date
    classes = merger.merge("#{classes} rounded-tr-lg") if last_day_week(calendar_date.beginning_of_month) === date
    classes = merger.merge("#{classes} rounded-bl-lg") if first_day_week(calendar_date.end_of_month) === date
    classes
  end

  def year_view_time_classes(calendar_date, date)
    merger = TailwindMerge::Merger.new
    classes = ""
    base_classes = "mx-auto flex h-7 w-7 items-center justify-center rounded-full"
    classes = merger.merge("#{base_classes} bg-indigo-600 font-semibold text-white") if date === Date.today
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
end
