# User
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :jars, -> { includes(:contributors) }, dependent: :destroy, foreign_key: :owner_id
  has_many :contributions, dependent: :destroy
  has_many :contributed_jars, -> { uniq.includes(:contributors) }, through: :contributions, source: :jar
  has_many :invitations, dependent: :destroy
  has_many :invited_jars, -> { uniq.includes(:contributors) }, through: :invitations, source: :jar
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  after_commit :schedule_import_contacts, on: :update
  after_commit :schedule_check_paypal, on: :update

  # returns user's handle
  def handle
    return name if name
    email
  end

  # returns jars that the user have not created
  def discoverable_jars
    Jar.visible - jars - invited_jars
  end

  # returns jars that the user have not yet contributed to
  def uncontributed_jars
    jars - contributed_jars
  end

  # A method nedeed by omniauth-google-oauth2 gem
  # User is being created if it does not exist
  def self.find_for_google_oauth2(access_token, _ = nil)
    data = access_token.info
    User.where(email: data['email']).first_or_create(
      name: data['name'],
      refresh_token: (access_token.credentials) ? access_token.credentials.refresh_token : nil
    )
  end

  def self.with_paypal_account
    where(paypal_member: true)
  end

  # Gets the access_token using users's refresh token
  def access_token
    return unless refresh_token
    client = OAuth2::Client.new(
      ENV['GOOGLE_CLIENT_ID'],
      ENV['GOOGLE_CLIENT_SECRET'],
      site: 'https://accounts.google.com',
      authorize_url: '/o/oauth2/auth',
      token_url: '/o/oauth2/token'
    )
    OAuth2::AccessToken.from_hash(client, refresh_token: refresh_token).refresh!
  end

  # import user's contacts from google
  def import_contacts
    return unless access_token
    google_contacts_user = GoogleContactsApi::User.new(access_token)
    contact_details = get_contact_details(google_contacts_user)
    contact_details.each do |contact_detail|
      friend = User.where(email: contact_detail[:email].downcase).first_or_create(contact_detail)
      friends << friend unless friends.include?(friend)
    end
    update_attribute(:last_contact_sync_at, Time.zone.now)
  end

  def check_paypal
    update_attribute(:paypal_member, User.paypal_account?(email))
  end

  def get_contact_details(google_contacts_user)
    contact_info = google_contacts_user.contacts.map do |contact|
      { email: contact.primary_email, name: contact.full_name }
    end
    contact_info.reject { |contact| contact[:email].nil? }
  end

  def self.paypal_account?(email)
    api = PayPal::SDK::AdaptiveAccounts::API.new
    get_verified_status = api.build_get_verified_status(
      emailAddress: email,
      matchCriteria: 'NONE'
    )
    get_verified_status_response = api.get_verified_status(get_verified_status)
    if get_verified_status_response.accountStatus == 'VERIFIED'
      Rails.logger.info get_verified_status_response.accountStatus
    else
      Rails.logger.error get_verified_status_response.error
    end
    get_verified_status_response.accountStatus == 'VERIFIED'
  end

  # Scehdule an import of the user's contact list after it is committed
  def schedule_import_contacts
    FriendSyncWorker.perform_async(id) # if last_contact_sync_at.nil?
  end

  def schedule_check_paypal
    PayPalChecker.perform_in(10.seconds, id) if paypal_member.nil?
  end
end
