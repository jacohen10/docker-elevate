class Category < ActiveRecord::Base
  belongs_to  :restaurant
  has_many :menus, dependent: :destroy
  has_many :sides, dependent: :destroy
end
