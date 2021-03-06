require 'rails_helper'

RSpec.describe Contribution, type: :model do
  # Relations
  it { should belong_to(:user) }
  it { should belong_to(:pot) }

  # Validations
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:pot) }

  # Attributes
  it { is_expected.to monetize(:amount) }

  # DB indexes
  it { should have_db_index(:user_id) }
  it { should have_db_index(:pot_id) }

  describe 'should be' do
    let!(:user) { create(:user) }
    let!(:pot) { create(:pot, guests: [user]) }
    let(:contribution) { build(:contribution, user: user, amount: 200, pot: pot) }

    it "valid if owner's total donations to this pot < 2000$" do
      user.contributions << create_list(:contribution, 2, amount: 100, pot: pot)
      expect(contribution).to be_valid
    end
    it "invalid if owner's total donations to this pot >= 2000$" do
      user.contributions << create_list(:contribution, 2, amount: 900, pot: pot)
      expect(contribution).not_to be_valid
    end
  end

  # States
  it { should have_states :initiated, :failed, :completed, :scheduled, :schedule_failed }
  ## Initiated
  it { should handle_events :success, :error, when: :initiated }
  it { should reject_events :retry, when: :initiated }
  ## Scheduled
  it { should handle_events :success, :error, when: :scheduled }
  it { should reject_events :retry, when: :scheduled }
  ## Failed
  it { should reject_events :success, :error, when: :failed }
  it { should handle_events :retry, when: :failed }
  ## Completed
  it { should reject_events :success, :error, :retry, when: :completed }
  ## Schedule Failed
  it { should handle_events :retry, when: :schedule_failed }
  it { should reject_events :success, :error, when: :schedule_failed }
  ## Completed
  it { should reject_events :success, :error, :retry, when: :completed }

  ## Schedule Failed
  it { should handle_events :retry, when: :schedule_failed }
  it { should reject_events :success, :error, when: :schedule_failed }

  # Concerns
  it_behaves_like 'payable'

  # DB
  it { should have_db_index(:user_id) }
  it { should have_db_index(:pot_id) }

  describe '#' do
    describe 'payment_time' do
      it 'should return time dif to pot ent_at' do
        contribution = create(:contribution, :anonymous)
        Timecop.freeze(Time.zone.now) do
          expect(contribution.payment_time).to eq(contribution.pot.end_at - Time.zone.now)
        end
      end
    end

    describe 'owner_name' do
      it 'should return N/A if contribution is anonymous' do
        contribution = create(:contribution, :anonymous)
        expect(contribution.owner_name).to eq('N/A')
      end

      it 'should return user email if it didn\'t set' do
        user = create(:user, first_name: nil, last_name: nil)
        contribution = create(:contribution, anonymous: false, user: user)
        expect(contribution.owner_name).to eq(contribution.user.email)
      end

      it 'should return user full_name if set' do
        user = create(:user, first_name: 'John', last_name: 'Doe')
        contribution = create(:contribution, anonymous: false, user: user)
        expect(contribution.owner_name).to eq('John Doe')
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

        before :each do
          contribution.success!
        end

        it 'updates status column to completed if payment completes' do
          expect(contribution.state).to eq('completed')
        end

        it 'updates paid_at column of pot if payment completes' do
          expect(contribution.pot.paid_at).not_to eq(nil)
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
  end

  # Validations
  describe 'validations' do
    describe 'amount_inside_the_pot_bounds' do
      it 'should return true if pot has no upper bound' do
        pot = create(:pot)
        contribution = build(:contribution, pot: pot)
        expect(contribution.valid?).to eq true
      end

      it 'should return true if amount is below upper bound' do
        pot = create(:pot, upper_bound: Money.new(1_000, 'USD'))
        contribution = build(:contribution, pot: pot, amount: Money.new(900, 'USD'))
        expect(contribution.valid?).to eq true
      end

      it 'should return fale if amount is above upper bound' do
        pot = create(:pot, upper_bound: Money.new(1_000, 'USD'))
        contribution = build(:contribution, pot: pot, amount: Money.new(1_100, 'USD'))
        expect(contribution.valid?).to eq false
      end
    end

    describe 'minimum_amount' do
      it 'should validate the minimum amount for a contribution' do
        pot = create(:pot)
        contribution = build(:contribution, pot: pot, amount: Money.new(99, 'USD'))
        expect(contribution.valid?).to eq false
      end
    end

    describe 'limit_per_user_per_pot' do
      let!(:user) { create(:user) }
      let!(:pot) { create(:pot, guests: [user]) }

      it 'should return error if user contributed more than 4 for a pot' do
        create_list(:contribution, 4, user: user, pot: pot, amount: Money.new(1000, 'USD'))
        contribution = create(:contribution, user: user, pot: pot, amount: Money.new(1000, 'USD'))
        expect(contribution.valid?).to eq false
      end

      it 'should validate contribution if user contributed less than 4 for a pot' do
        contribution = create(:contribution, user: user, pot: pot, amount: Money.new(1000, 'USD'))
        expect(contribution.valid?).to eq true
      end
    end
  end
end
