class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  has_many :jars, dependent: :destroy, foreign_key: :owner_id
  has_many :contributions
  has_many :contributed_jars, through: :contributions, class_name: Jar
end
