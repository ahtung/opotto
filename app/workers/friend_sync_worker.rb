# FriendSyncWorker
class FriendSyncWorker
  include Sidekiq::Worker

  # perform worker
  def perform(user_id)
    user = User.find(user_id)
    google_contacts_user = GoogleContactsApi::User.new(user.access_token)
    google_contacts_user.contacts.each do |contact|
      ActiveRecord::Base.transaction do
        user.contacts.where(email: contact.primary_email).first_or_create(name: contact.fullName, password: Devise.friendly_token[0, 20])
      end
    end
  end
end
