class User < ActiveRecord::Base
  has_many :customers, dependent: :destroy
  has_many :restaurants, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  ROLES = %w[admin restaurant customer]

end
