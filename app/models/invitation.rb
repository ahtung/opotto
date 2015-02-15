# Invitation
class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  after_commit :invite_user, on: :create

  private

  def invite_user
    UserMailer.invitation_email(user)
  end
end
