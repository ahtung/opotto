require 'rails_helper'

describe 'User' do
  let!(:user) { FactoryGirl.create(:user, :with_jars, :with_contributions) }
  
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
  
  it 'should be able to make multiple contributions to the same jar' do
    jar = user.contributed_jars.first
    visit jar_path(jar)
    click_on 'Contribute'
    fill_in 'contribution_amount', with: 1000
    click_on 'Save'
    
    expect(page).to have_content('Contribution was successfully created.')
  end
  
  it "should be able to contribute to someone else's own jar" do
    another_user = FactoryGirl.create(:user)
    jar = FactoryGirl.create(:jar, owner: another_user)
    visit jar_path(jar)
    click_on 'Contribute'
    fill_in 'contribution_amount', with: 1000
    click_on 'Save'
    
    expect(page).to have_content('Contribution was successfully created.')
  end
end