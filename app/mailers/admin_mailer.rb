# Admin Mailer
class AdminMailer < ApplicationMailer
  def update_email
    @admins = User.admin
    @pots = Pot.this_week
    mail to: @admins.pluck(:email), subject: "This week's pots"
  end
end
