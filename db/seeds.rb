if Rails.env.development?
  User.delete_all
  Pot.delete_all
  Friendship.delete_all
  Invitation.delete_all
  Contribution.delete_all

  onur = FactoryGirl.create(:user, :admin, :with_pots, :with_contributions, email: 'onurkucukkece@ahtung.co', first_name: 'Onur', last_name: 'Kucukkece', password: '123QwETR')
  dunya = FactoryGirl.create(:user, :admin, :with_pots, :with_contributions, email: 'dunyakirkali@ahtung.co', first_name: 'Dunya', last_name: 'Kirkali', password: '123QwETR')
  ilana = FactoryGirl.create(:user, :admin, :with_pots, :with_contributions, email: 'contact@madco.nl', first_name: 'Ilana', last_name: 'Marcovic', password: '123QwETR')
  us = FactoryGirl.create(:user, password: '123QwETR')

  onur.friends << [dunya, us, ilana]
  dunya.friends << [onur, us, ilana]
  ilana.friends << [dunya, onur, us]

  # Random Pots
  FactoryGirl.create_list(:pot, 2, :with_contributions, guests: [dunya, onur] + FactoryGirl.create_list(:user, 2))
  FactoryGirl.create_list(:pot, 2, :closed, :with_contributions, guests: [dunya, onur] + FactoryGirl.create_list(:user, 2))
  FactoryGirl.create_list(:pot, 2, :ended, :with_contributions, guests: [dunya, onur] + FactoryGirl.create_list(:user, 2))
elsif Rails.env.production?
  Pot.where(name: 'PayPal test Pot').destroy_all
  onur = User.where(email: 'onurkucukkece@ahtung.co').first_or_create
  dunya = User.where(email: 'dunyakirkali@ahtung.co').first_or_create
  ilana = User.where(email: 'contact@madco.nl').first_or_create
  receiver = User.where(email: 'opotto-p-receiver@gmail.com').first_or_create
  FactoryGirl.create(:pot, name: 'Test Pot',  owner: dunya, guests: [dunya, onur, ilana], visible: true, receiver: receiver)
end
