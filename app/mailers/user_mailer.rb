# UserMailer
class UserMailer < ActionMailer::Base
  layout 'mailer'
  default from: 'info@ahtung.co'

  # sends an invitation email to given user about the pot
  def invitation_email(user, pot)
    @user = user
    @pot = pot
    mail(subject: "You're invited to contribute!", to: user.email)
  end
end
