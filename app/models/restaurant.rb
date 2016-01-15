class Restaurant < ActiveRecord::Base
  has_many :meals, dependent: :destroy
  accepts_nested_attributes_for :meals
  has_many  :customers, through: :meals
  has_many :menus, dependent: :destroy
  has_many :open_times, dependent: :destroy

  def is_open
    # output = false
    # if
    #   (self.open_times.where(day: Time.now.strftime("%A")).count ===1 &&
    #   (((self.open_times.where(day:Time.now.strftime("%A"))[0].opening.strftime("%H.%M") < Time.now.strftime("%H.%M")) && (self.open_times.where(day:Time.now.strftime("%A"))[0].closing.strftime("%H.%M") > Time.now.strftime("%H.%M")) ) || ((self.open_times.where(day:Time.now.strftime("%A"))[1].opening.exists?.strftime("%H.%M") < Time.now.strftime("%H.%M")) && (self.open_times.where(day:Time.now.strftime("%A"))[1].closing.strftime("%H.%M") > Time.now.strftime("%H.%M")) ) )   ) then output = true
    # end
    # # if monday is an open Time
    # # if the current time is an open time
    # #
    # # .open_times.where(day: Time.now.strftime("%A")).count ===1 && ((restaurant.open_times.find_by(day:Time.now.strftime("%A")).opening.strftime("%H.%M") < Time.now.strftime("%H.%M")) && (restaurant.open_times.find_by(day:Time.now.strftime("%A")).closing.strftime("%H.%M") > Time.now.strftime("%H.%M")) )
    # return output
  end
end
