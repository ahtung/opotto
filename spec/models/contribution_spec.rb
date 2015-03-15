require 'rails_helper'

describe Contribution do
  it { should belong_to(:user) }
  it { should belong_to(:jar) }
  it { should monetize(:amount_cents) }

  describe '#owner_name' do
    it 'should return N/A if contribution is anonymous' do
      contribution = FactoryGirl.create(:contribution, :anonymous)
      expect(contribution.owner_name).to eq('N/A')
    end

    it 'should return user email if it didn\'t set' do
      contribution = FactoryGirl.create(:contribution, :with_user_noname)
      expect(contribution.owner_name).to eq(contribution.user.email)
    end

    it 'should return user full_name if set' do
      contribution = FactoryGirl.create(:contribution, :with_user_with_name)
      expect(contribution.owner_name).to eq(contribution.user.name)
    end
  end
end
