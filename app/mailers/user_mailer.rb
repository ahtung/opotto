class UserMailer < ApplicationMailer
  default from: 'invitations@potto.com'

  def invitation_email(users)
    @users = users
    mail(subject: "You're invited to contribute'!", to: users.map(&:email))
  end
end
