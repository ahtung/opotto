# UserMailer
class UserMailer < ApplicationMailer
  default from: 'no-reply@opotto.com'

  # sends an invitation email to given user about the jar
  def invitation_email(user, jar)
    @user = user
    @jar = jar
    mail(subject: "You're invited to contribute!", to: user.email)
  end

  # sends an payout email to given user about the jar
  def payout_email(user, jar)
    @user = user
    @jar = jar
    mail(subject: "You have contributed!", to: user.email)
  end
end
