require 'test_helper'

class CalendarHelperTest < ActionView::TestCase
  include CalendarHelper

  setup do
    @events = []
    @events << OpenStruct.new(title: "Der Name meines Events", date_time: DateTime.parse("10.01.2024 17:22") , color: "bg-green-500")
    @events << OpenStruct.new(title: "Noch ein tolles Event", date_time: DateTime.parse("17.01.2024 08:30"), color: "bg-blue-500")
    @events << OpenStruct.new(title: "Ein anderes Event in der Vergangenheit", date_time: DateTime.parse("30.01.2024 15:00"), color: "bg-blue-500")
    @events << OpenStruct.new(title: "Der 24 Event", date_time: DateTime.parse("24.01.2024 12:00"), color: "bg-blue-500")
    @events << OpenStruct.new(title: "Der 24 Event", date_time: DateTime.parse("24.01.2024 15:00"), color: "bg-blue-500")
  end

  test '#compact_month_calendar tests if the correct partial is rendered' do
    date = Date.today
    render partial: 'calendar/compact_month_calendar', locals: { date:, navigation: false, events: []}
    assert_select 'div.font-semibold', text: "#{I18n.l(date, format: "%B")} #{date.year}"
  end

  test '#first_day_of_month_range tests if the 15. of a month is the first date of a month range' do
    month_date = Date.today
    day = Date.new(month_date.year, month_date.month, 15)
    range = whole_month_range(month_date)
    assert_not first_day_of_month_range(range, day)
  end

  test '#first_day_of_month_range tests if a specific date is the first date of a month range' do
    # use December 2023
    month_date = Date.new(2023, 12, 1)
    # 27.11.2023 is the first day of the week in the first week of December
    day = Date.new(month_date.year, 11, 27)
    range = whole_month_range(month_date)
    assert first_day_of_month_range(range, day)
  end

  test '#last_day_of_first_week tests if a date is the last day of the first month week' do
    month_date = Date.today
    day = Date.new(month_date.year, month_date.month, 15)
    assert_not last_day_of_first_week(month_date, day)
  end

  test '#last_day_of_first_week tests if a date is the last day of the first month week and should return true' do
    # use December 2023
    month_date = Date.new(2023, 12, 1)
    # 03.12.2023 is the last day of the week in the first week of December
    day = Date.new(month_date.year, 12, 3)
    assert last_day_of_first_week(month_date, day)
  end

  test '#first_day_of_last_week tests if a date is the first day of the first month week' do
    # use December 2023
    month_date = Date.new(2023, 12, 1)
    # 27.11.2023 is the first day of the week in the first week of December
    day = Date.new(month_date.year, 11, 27)
    assert_not first_day_of_last_week(month_date, day)
  end

  test '#first_day_of_last_week tests if a date is the first day of the first month week and should return true' do
    # use December 2023
    month_date = Date.new(2023, 12, 1)
    # 27.11.2023 is the first day of the week in the first week of December
    day = Date.new(month_date.year, 12, 25)
    assert first_day_of_last_week(month_date, day)
  end

  test '#last_day_of_month_range tests if the 15. of a month is the first date of a month range' do
    month_date = Date.today
    day = Date.new(month_date.year, month_date.month, 15)
    range = whole_month_range(month_date)
    assert_not last_day_of_month_range(range, day)
  end

  test '#last_day_of_month_range tests if a specific date is the first date of a month range' do
    # use January 2024
    month_date = Date.new(2024, 1, 1)
    # 04.02.2024 is the last day of the week in the last week of January
    day = Date.new(month_date.year, 2, 4)
    range = whole_month_range(month_date)
    assert last_day_of_month_range(range, day)
  end

  test '#events_for_day tests if multipe events are returned' do
    day = Date.new(2024, 1, 24)
    result = events_for_day(day, @events)
    assert_equal 2, result.count
  end

  test '#events_for_day tests if one event is returned' do
    day = Date.new(2024, 1, 10)
    result = events_for_day(day, @events)
    assert_equal 1, result.count
  end

  test '#find_event tests if one event is returned' do
    day = Date.parse "10.01.2024"
    result = find_event(day, @events)
    assert_equal "Der Name meines Events", result.title
  end

  test '#wday_for_date Wednesday' do
    day = Date.parse "10.01.2024"
    assert_equal 3, wday_for_date(day)
  end

  test '#wday_for_date Sunday' do
    day = Date.parse "14.01.2024"
    assert_equal 7, wday_for_date(day)
  end

  test '#duration for event' do
    start_time = DateTime.parse("10.01.2024 17:00")
    end_time = DateTime.parse("10.01.2024 18:00")
    assert_equal 1, duration(start_time, end_time)

    start_time = DateTime.parse("10.01.2024 17:00")
    end_time = DateTime.parse("10.01.2024 17:30")
    assert_equal 0.5, duration(start_time, end_time)    

    start_time = DateTime.parse("10.01.2024 00:00")
    end_time = DateTime.parse("10.01.2024 00:30")
    assert_equal 0.5, duration(start_time, end_time)

    start_time = DateTime.parse("10.01.2024 03:00")
    end_time = DateTime.parse("10.01.2024 15:30")
    assert_equal 12.5, duration(start_time, end_time)
  end

  test '#week_event_classes' do
    start_time = DateTime.parse("10.01.2024 17:00")
    end_time = DateTime.parse("10.01.2024 18:00")
    result = week_event_classes(start_time, end_time)
    assert_equal ["relative mt-px flex sm:col-start-3", "grid-row: 206 / span 12"], result

    start_time = DateTime.parse("14.01.2024 00:00")
    end_time = DateTime.parse("14.01.2024 00:30")
    result = week_event_classes(start_time, end_time)
    assert_equal ["relative mt-px flex sm:col-start-7", "grid-row: 2 / span 6"], result    

    start_time = DateTime.parse("14.01.2024 12:00")
    end_time = DateTime.parse("14.01.2024 15:30")
    result = week_event_classes(start_time, end_time)
    assert_equal ["relative mt-px flex sm:col-start-7", "grid-row: 146 / span 42"], result        
  end

  test '#beginning_week_number' do
    result = beginning_week_number(DateTime.parse("10.01.2024 17:00"))
    assert_equal 206, result
  end
end
