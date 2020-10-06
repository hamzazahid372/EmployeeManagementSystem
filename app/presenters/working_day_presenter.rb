class WorkingDayPresenter
  attr_reader :working_day

  def initialize(working_day)
    @working_day = working_day
  end

  def from
    working_day.from.strftime("%I:%M%p")
  end

  def to
    working_day.to.strftime("%I:%M%p")
  end

  def off_day
    working_day.off_day? ? 'Yes' : 'No'
  end

  def day
    WorkingDay::DAY_NAMES[working_day.day.to_i]
  end
end
