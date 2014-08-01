require 'rails_helper'

describe 'User' do
  let!(:user) { FactoryGirl.create(:user) }
  
  before :each do
    login user
  end
  
  it 'should be able to create a new pot' do
    visit root_path
    click_on 'new pot'
    fill_in 'name', with: 'Joelle getting married'
    click_on 'done'
    
    expect(page).to have_content('pot created')
  end
end