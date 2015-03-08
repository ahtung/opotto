# User
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :jars, dependent: :destroy, foreign_key: :owner_id
  has_many :contributions, dependent: :destroy
  has_many :contributed_jars, -> { uniq }, through: :contributions, source: :jar
  has_many :invitations, dependent: :destroy
  has_many :invited_jars, -> { uniq }, through: :invitations, source: :jar
  has_many :friendships
  has_many :contacts, through: :friendships, source: :user

  after_commit :schedule_import_contacts

  # returns jars that the user have not created
  def discoverable_jars
    Jar.visible - jars - contributed_jars + contributed_jars.visible
  end

  # returns jars that the user have not yet contributed to
  def uncontributed_jars
    jars - contributed_jars
  end

  # A method nedeed by omniauth-google-oauth2 gem
  # User is being created if it does not exist
  def self.find_for_google_oauth2(access_token, signed_in_resource = nil)
    data = access_token.info
    User.where(email: data['email']).first_or_create(
      name: data['name'],
      refresh_token: (access_token.credentials) ? access_token.credentials.refresh_token : nil
    )
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

  # import user's contacts from google
  def import_contacts
    return unless access_token
    google_contacts_user = GoogleContactsApi::User.new(access_token)
    google_contacts_user.contacts.each do |contact|
      ActiveRecord::Base.transaction do
        contacts.where(email: contact.primary_email).first_or_create(
          name: contact.fullName
        )
      end
    end
  end

  private

  # Scehdule an import of the user's contact list after it is committed
  def schedule_import_contacts
    FriendSyncWorker.perform_async(id)
  end
end
