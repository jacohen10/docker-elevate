class Restaurant < ActiveRecord::Base
  has_many :meals, dependent: :destroy
  has_many  :customers, through: :meals
  has_many :menus, dependent: :destroy
  has_many :open_times, dependent: :destroy
end
