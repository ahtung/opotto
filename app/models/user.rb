# User
class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :pots, -> { includes(:contributors) }, dependent: :destroy, foreign_key: :owner_id
  has_many :contributions, dependent: :destroy
  has_many :contributed_pots, -> { distinct.includes(:contributors) }, through: :contributions, source: :pot
  has_many :invitations, dependent: :destroy
  has_many :invited_pots, -> { distinct.includes(:contributors) }, through: :invitations, source: :pot
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  default_scope { order(:first_name) }
  scope :admin, -> { where(admin: true) }
  scope :unsynced_for_a_while, -> { where('last_contact_sync_at < ? OR last_contact_sync_at IS NULL', 1.week.ago.in_time_zone) }

  # Atachment
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}

  def name
    return [first_name, last_name].join(' ') if first_name && last_name
    email
  end

  def name?
    return true if first_name && last_name
    false
  end

  def email_hash
    Digest::MD5.hexdigest(email)
  end

  # returns pots that the user have not created
  def discoverable_pots
    Pot.visible - pots - invited_pots
  end

  # returns pots that the user have not yet contributed to
  def uncontributed_pots
    pots - contributed_pots
  end

  # A method nedeed by omniauth-google-oauth2 gem
  # User is being created if it does not exist
  def self.find_for_google_oauth2(access_token, _ = nil)
    data = access_token.info
    User.where(email: data['email']).first_or_create(
      first_name: data['first_name'],
      last_name: data['last_name'],
      refresh_token: access_token.credentials ? access_token.credentials.refresh_token : nil,
      admin: false
    )
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
    batch_import_contacts(contact_details)
    update_attribute(:last_contact_sync_at, Time.zone.now)
  end

  def batch_import_contacts(contact_details)
    ActiveRecord::Base.transaction do
      contact_details.each do |contact_detail|
        friend = User.where(email: contact_detail[:email].downcase).first_or_create(contact_detail)
        friends << friend unless friends.include?(friend)
      end
    end
  end

  def get_contact_details(google_contacts_user)
    puts google_contacts_user.inspect
    contact_info = google_contacts_user.contacts.map do |contact|
      { email: contact.primary_email, first_name: contact.given_name, last_name: contact.family_name }
    end
    contact_info.reject { |contact| contact[:email].nil? }
  end
end
