require 'rails_helper'

describe 'User' do
  let!(:user) { FactoryGirl.create(:user, :with_jars) }
  
  before :each do
    login user
  end
  
  it 'should be able to contribute to his/her own jar' do
    jar = user.jars.first
    visit jar_path(jar)
    click_on 'Contribute'
    fill_in 'contribution_amount', with: 1000
    click_on 'Save'
    
    expect(page).to have_content('Contribution was successfully created.')
  end
end