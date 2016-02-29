class Restaurant < ActiveRecord::Base
  has_many :meals, dependent: :destroy
  accepts_nested_attributes_for :meals
  has_many  :customers, through: :meals
  has_many :menus, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :open_times, dependent: :destroy
  belongs_to :user

  def has_business_hours
    output = false
    if
      self.open_times.where(day: Time.now.strftime("%A")).count >0
      then output = true;
      return output
    end
  end

  def has_two_business_hours
    output = false
    if self.open_times.where(day: Time.now.strftime("%A")).count ==2
      then output = true;
      return output
    end
  end

  def is_open_one
    output = false
    if
      #check if restaurant has business hours for today
      (self.has_business_hours &&
      # opening time is less than or equal to current time
      ((self.opening_time(0).to_i <= Time.now.strftime("%H.%M").to_i) &&
      # closing time is greater than current time
      (self.closing_time(0).to_i > Time.now.strftime("%H.%M").to_i) )  )
      then output = true;

    end
    return output
  end

  def is_open_two
    output = false
    if
      #check if restaurant has 2 sets of business hours for today
      (self.has_two_business_hours &&
      #check if 2nd opening time is less than or equal to current time
      ((self.opening_time(1) <= Time.now.strftime("%H.%M")) &&
      #check if 2nd closing time is greater than current time
      (self.closing_time(1) > Time.now.strftime("%H.%M")) )  )
      then output = true;
      return output
    end
  end

  def opening_time(set_of_hours)
      return self.open_times.where(day:Time.now.strftime("%A"))[set_of_hours].opening.strftime("%H.%M")
  end

  def closing_time(set_of_hours)
      return self.open_times.where(day:Time.now.strftime("%A"))[set_of_hours].closing.strftime("%H.%M")
  end

  def opening_time_view(set_of_hours)
      return self.open_times.where(day:Time.now.strftime("%A"))[set_of_hours].opening.strftime("%l:%M%p")
  end

  def closing_time_view(set_of_hours)
      return self.open_times.where(day:Time.now.strftime("%A"))[set_of_hours].closing.strftime("%l:%M%p")
  end


end
