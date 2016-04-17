if Rails.env.development?
  User.delete_all
  Pot.delete_all
  Friendship.delete_all
  Invitation.delete_all
  Contribution.delete_all

  onur = FactoryGirl.create(:user, :admin, email: 'onurkucukkece@gmail.com', password: '123QwETR', paypal_member: true)
  dunya = FactoryGirl.create(:user, :admin, email: 'dunyakirkali@gmail.com', :with_contributions, password: '123QwETR', paypal_member: true)
  ilana = FactoryGirl.create(:user, :admin, email: 'contact@madco.nl', password: '123QwETR', paypal_member: true)
  us = FactoryGirl.create(:user, :with_paypal, password: '123QwETR')

  onur.friends << [dunya, us, ilana]
  dunya.friends << [onur, us, ilana]
  ilana.friends << [dunya, onur, us]

  # Random Pots
  FactoryGirl.create_list(:pot, 2, :with_contributions, guests: [dunya, onur] + FactoryGirl.create_list(:user, 2))
  FactoryGirl.create_list(:pot, 2, :closed, :with_contributions, guests: [dunya, onur] + FactoryGirl.create_list(:user, 2))
  FactoryGirl.create_list(:pot, 2, :ended, :with_contributions, guests: [dunya, onur] + FactoryGirl.create_list(:user, 2))
elsif Rails.env.production?
  Pot.where(name: 'PayPal test Pot').destroy_all
  onur = User.where(email: 'onurkucukkece@gmail.com').first_or_create
  dunya = User.where(email: 'dunyakirkali@gmail.com').first_or_create
  ilana = User.where(email: 'contact@madco.nl').first_or_create
  paypal = User.where(email: 'paypal@opotto.com').first_or_create
  receiver = User.where(email: 'opotto-p-receiver@gmail.com').first_or_create
  FactoryGirl.create(:pot, name: 'PayPal test Pot',  owner: dunya, guests: [dunya, onur, paypal, ilana], visible: true, receiver: receiver)
end
