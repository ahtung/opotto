# Invitation
class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :pot

  after_commit :invite_user, on: :create

  # Invites the user via email
  def invite_user
    UserMailer.invitation_email(user, pot).deliver_now
  end
end
