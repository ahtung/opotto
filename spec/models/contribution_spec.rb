require 'rails_helper'

RSpec.describe Contribution, type: :model do
  # Relations
  it { should belong_to(:user) }
  it { should belong_to(:jar) }
  it { should monetize(:amount_cents) }

  # States
  it { should have_states :initiated, :failed, :completed }
  it { should handle_events :success, :error, when: :initiated }
  it { should handle_events :retry, when: :failed }

  # Concerns
  it_behaves_like "payable"

  describe '#' do
    describe 'payment_time' do
      it 'should return time dif to jar ent_at' do
        contribution = FactoryGirl.create(:contribution, :anonymous)
        Timecop.freeze(Time.zone.now) do
          expect(contribution.payment_time).to eq(contribution.jar.end_at - Time.zone.now)
        end
      end
    end

    describe 'owner_name' do
      it 'should return N/A if contribution is anonymous' do
        contribution = FactoryGirl.create(:contribution, :anonymous)
        expect(contribution.owner_name).to eq('N/A')
      end

      it 'should return user email if it didn\'t set' do
        contribution = FactoryGirl.create(:contribution, :with_user_noname, anonymous: false)
        expect(contribution.owner_name).to eq(contribution.user.email)
      end

      it 'should return user full_name if set' do
        contribution = FactoryGirl.create(:contribution, :with_user_with_name, anonymous: false)
        expect(contribution.owner_name).to eq(contribution.user.name)
      end
    end

    describe 'success' do
      let(:contribution) { create(:contribution, state: :initiated) }

      it 'updates status column to completed if payment completes' do
        contribution.payment_key = 'PK-ASD123ADASDAS'
        contribution.success!
        expect(contribution.state).to eq('completed')
      end
    end

    describe 'fail' do
      let(:contribution) { create(:contribution, state: :initiated) }

      it 'updates status column to failed if payment fails' do
        contribution.error!
        expect(contribution.state).to eq('failed')
      end
    end

    describe 'pay' do
      let(:contribution) { create(:contribution) }

      xit 'updates payment_key column' do
        contribution.pay
        expect(contribution.payment_key).not_to eq(nil)
      end

      xit 'updates authorization_url attr_accessor' do
        contribution.pay
        expect(contribution.authorization_url).not_to eq(nil)
      end
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
