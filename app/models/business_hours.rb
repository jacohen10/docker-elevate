module BusinessHours
  def has_business_hours?
    open_times.where(day: current_day).count > 0
  end

  def check_business_hours_count_equals(sets)
    open_times.where(day: current_day).count == sets
  end

  def is_open_one?
    # check if restaurant has business hours for today
    (has_business_hours? &&
    # opening time is less than or equal to current time
    ((opening_time(0).to_f <= current_time) &&
    # closing time is greater than current time
    (closing_time(0).to_f > current_time)))
  end

  def is_open_two?
    # check if restaurant has 2 sets of business hours for today
    (check_business_hours_count_equals(2) &&
    # check if 2nd opening time is less than or equal to current time
    ((opening_time(1) <= current_time) &&
    # check if 2nd closing time is greater than current time
    (closing_time(1) > current_time)))
  end

  def is_closed?
    # if no business hours exist for today
    (has_business_hours? == false ||
    # opening time is greater than or equal to current time
    ((check_business_hours_count_equals(1) && is_open_one? == false) ||
    # closing time is less than or equal to current time
    (check_business_hours_count_equals(2) && is_open_one? == false && is_open_two? == false)))
  end

  def opening_time(set_of_hours)
    open_times.where(day: current_day)[set_of_hours].opening.strftime('%H.%M').to_f
  end

  def closing_time(set_of_hours)
    open_times.where(day: current_day)[set_of_hours].closing.strftime('%H.%M').to_f
  end

  def opening_time_view(set_of_hours)
    open_times.where(day: current_day)[set_of_hours].opening.strftime('%l:%M%p')
  end

  def closing_time_view(set_of_hours)
    open_times.where(day: current_day)[set_of_hours].closing.strftime('%l:%M%p')
  end

  def current_time
    Time.now.strftime('%H.%M').to_f
  end

  def current_day
    Time.now.strftime('%A')
  end
end
