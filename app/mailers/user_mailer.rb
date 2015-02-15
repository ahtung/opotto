class UserMailer < ApplicationMailer
  default from: 'invitations@potto.com'

  def invitation_email(user, jar)
    @user = user
    @jar = jar
    mail(subject: "You're invited to contribute'!", to: user.email)
  end
end
