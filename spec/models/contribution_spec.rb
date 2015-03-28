require 'rails_helper'

RSpec.describe Contribution, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:jar) }
  it { should monetize(:amount_cents) }

  describe '#owner_name' do
    it 'should return N/A if contribution is anonymous' do
      contribution = FactoryGirl.create(:contribution, :anonymous)
      expect(contribution.owner_name).to eq('N/A')
    end

    xit 'should return user email if it didn\'t set' do
      contribution = FactoryGirl.create(:contribution, :with_user_noname)
      expect(contribution.owner_name).to eq(contribution.user.email)
    end

    xit 'should return user full_name if set' do
      contribution = FactoryGirl.create(:contribution, :with_user_with_name)
      expect(contribution.owner_name).to eq(contribution.user.name)
    end
  end

  # Validations
  describe 'validations' do
    describe 'amount_inside_the_pot_bounds' do
      it 'should return true if jar has no upper bound' do
        jar = create(:jar)
        contribution = build(:contribution, jar: jar)
        expect(contribution.valid?).to eq true
      end

      it 'should return true if amount is below upper bound' do
        jar = create(:jar, upper_bound: 1000)
        contribution = build(:contribution, jar: jar, amount: 900)
        expect(contribution.valid?).to eq true
      end

      it 'should return false if amount is above bound' do
        jar = create(:jar)
        contribution = build(:contribution, jar: jar, amount: 1100)
        expect(contribution.valid?).to eq false
      end
    end
  end
end
