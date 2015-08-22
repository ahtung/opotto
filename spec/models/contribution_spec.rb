require 'rails_helper'

RSpec.describe Contribution, type: :model do
  # Relations
  it { should belong_to(:user) }
  it { should belong_to(:jar) }

  # Attributes
  it { is_expected.to monetize(:amount) }

  # States
  it { should have_states :initiated, :failed, :completed, :scheduled, :schedule_failed }
  it { should handle_events :success, :error, when: :initiated }
  it { should handle_events :success, :error, when: :scheduled }
  it { should handle_events :retry, when: :schedule_failed }
  it { should handle_events :retry, when: :failed }

  # Concerns
  it_behaves_like 'payable'

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

    # TODO: (onurkucukkece) Refactor to concern spec
    describe 'success' do
      describe 'when initiated' do
        let(:contribution) { create(:contribution, state: :initiated) }

        it 'updates status column to scheduled if payment scheduled' do
          contribution.success!
          expect(contribution.state).to eq('scheduled')
        end
      end

      describe 'when scheduled' do
        let(:contribution) { create(:contribution, state: :scheduled) }

        it 'updates status column to completed if payment completes' do
          contribution.success!
          expect(contribution.state).to eq('completed')
        end
      end
    end

    describe 'error' do
      describe 'when initiated' do
        let(:contribution) { create(:contribution, state: :initiated) }

        it 'updates status column to failed if payment fails' do
          contribution.error!
          expect(contribution.state).to eq('failed')
        end
      end

      describe 'when scheduled' do
        let(:contribution) { create(:contribution, state: :scheduled) }

        it 'updates status column to schedule_failed if payment fails' do
          contribution.error!
          expect(contribution.state).to eq('schedule_failed')
        end
      end
    end

    describe 'pay' do
      let(:contribution) { create(:contribution) }

      it 'updates payment_key column' do
        contribution.pay
        expect(contribution.payment_key).not_to eq(nil)
      end

      it 'updates authorization_url attr_accessor' do
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
        jar = create(:jar, upper_bound: Money.new(1_000, 'USD'))
        contribution = build(:contribution, jar: jar, amount: Money.new(900, 'USD'))
        expect(contribution.valid?).to eq true
      end

      xit 'should return fale if amount is above upper bound' do
        jar = create(:jar, upper_bound: Money.new(1_000, 'USD'))
        contribution = build(:contribution, jar: jar, amount: Money.new(1_100, 'USD'))
        expect(contribution.valid?).to eq false
      end

      xit 'should return false if amount is above bound' do
        jar = create(:jar)
        contribution = build(:contribution, jar: jar, amount: Money.new(1_100, 'USD'))
        expect(contribution.valid?).to eq false
      end
    end
  end
end
