class Customer < ActiveRecord::Base
  has_many :meals, dependent: :destroy
  has_many  :restaurants, through: :meals
  belongs_to :user
end
