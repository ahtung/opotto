# User
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :jars, dependent: :destroy, foreign_key: :owner_id
  has_many :contributions, dependent: :destroy
  has_many :contributed_jars, -> { uniq }, through: :contributions, source: :jar

  has_many :invitations, dependent: :destroy
  has_many :invited_jars, -> { uniq }, through: :invitations, source: :jar

  has_many :friendships
  has_many :contacts, through: :friendships, class_name: 'User'

  # invites users
  # def contacts
  #   # oauth_access_token_for_user = ''
  #   # GoogleContactsApi::User.new(oauth_access_token_for_user).contacts
  # end

  # returns jars that the user have not yet contributed to
  def uncontributed_jars
    jars - contributed_jars
  end
end
