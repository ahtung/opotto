User.delete_all
onur = FactoryGirl.create(:user, email: 'onurkucukkece@gmail.com', password: '123QwETR')
dunya = FactoryGirl.create(:user, email: 'dunyakirkali@gmail.com', password: '123QwETR')
us = FactoryGirl.create(:user, :with_paypal, password: '123QwETR')

onur.friends << [dunya, us]
dunya.friends << [onur, us]
