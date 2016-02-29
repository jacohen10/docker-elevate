class Meal < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant

  def is_cooking?
    status.eql? 'cooking'
  end
end
