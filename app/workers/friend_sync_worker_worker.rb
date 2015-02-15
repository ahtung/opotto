class FriendSyncWorkerWorker
  include Sidekiq::Worker

  def perform(user_id)
    user_id = User.find(user_id)
    google_contacts_user = GoogleContactsApi::User.new(access_token)
    google_contacts_user.contacts.each do |contact|
      ActiveRecord::Base.transaction do
        contacts.where(email: contact.primary_email).first_or_create(name: contact.fullName, password: Devise.friendly_token[0, 20])
      end
    end
  end
end
