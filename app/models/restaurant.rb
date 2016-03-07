class Restaurant < ActiveRecord::Base
  has_many :meals, dependent: :destroy
  accepts_nested_attributes_for :meals
  has_many  :customers, through: :meals
  has_many :menus, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :open_times, dependent: :destroy
  belongs_to :user

  include BusinessHours

end
