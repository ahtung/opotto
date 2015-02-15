# User
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :jars, dependent: :destroy, foreign_key: :owner_id
  has_many :contributions, dependent: :destroy
  has_many :contributed_jars, -> { uniq }, through: :contributions, source: :jar

  has_many :invitations, dependent: :destroy
  has_many :invited_jars, -> { uniq }, through: :invitations, source: :jar

  has_many :friendships
  has_many :contacts, through: :friendships, source: :user

  after_commit :import_contacts, on: :update

  # returns jars that the user have not yet contributed to
  def uncontributed_jars
    jars - contributed_jars
  end

  # A method nedeed by omniauth-google-oauth2 gem
  # User is being created if it does not exist
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
      data = access_token.info
      user = User.where(email: data['email']).first

      unless user
          user = User.create(name: data['name'],
             email: data['email'],
             password: Devise.friendly_token[0, 20],
             refresh_token: access_token.credentials.refresh_token
          )
      end
      user
  end

  private

  # Imports user's contact list after it is created
  def import_contacts
    return unless access_token
    google_contacts_user = GoogleContactsApi::User.new(access_token)
    google_contacts_user.contacts.each do |contact|
      contacts.where(email: contact.primary_email).first_or_create(name: contact.fullName, password: Devise.friendly_token[0, 20])
    end
  end

  # Gets the access_token using users's refresh token
  def access_token
    return unless refresh_token
    client = OAuth2::Client.new ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
       site: 'https://accounts.google.com',
       authorize_url: '/o/oauth2/auth',
       token_url: '/o/oauth2/token'
     }
     OAuth2::AccessToken.from_hash(client, refresh_token: refresh_token).refresh!
  end
end
