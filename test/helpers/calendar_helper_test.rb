require 'test_helper'

class CalendarHelperTest < ActionView::TestCase
  include CalendarHelper

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
  
end
