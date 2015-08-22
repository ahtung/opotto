# UserMailer
class UserMailer < ActionMailer::Base
  layout 'mailer'
  default from: 'info@opotto.com'

  # sends an invitation email to given user about the jar
  def invitation_email(user, jar)
    @user = user
    @jar = jar
    mail(subject: "You're invited to contribute!", to: user.email)
  end
end
