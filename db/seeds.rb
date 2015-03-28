User.delete_all
onur = FactoryGirl.create(:user, :onur)
dunya = FactoryGirl.create(:user, :dunya)
us = FactoryGirl.create(:user, :with_paypal)

onur.friends << [dunya, us]
dunya.friends << [onur, us]