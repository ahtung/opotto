class UserMailer < ApplicationMailer
  default from: 'invitations@potto.com'

  def invitation_email(user)
    @user = user
    mail(subject: "You're invited to contribute'!", to: user.email)
  end
end
