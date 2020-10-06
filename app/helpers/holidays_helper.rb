module HolidaysHelper
  def holiday_day(holiday)
    if holiday.every_year?
      holiday.day.strftime("%B, %d")
    else
      holiday.day.to_s(:long)
    end
  end
end
