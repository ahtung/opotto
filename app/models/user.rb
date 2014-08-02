class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  has_many :jars, dependent: :destroy, foreign_key: :owner_id
  has_many :contributions, :dependent => :destroy
  has_many :contributed_jars, -> { uniq }, through: :contributions, source: :jar
  
  def uncontributed_jars
    jars - contributed_jars
  end
end
