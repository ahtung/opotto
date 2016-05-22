require 'rails_helper'

RSpec.describe Pot, type: :model do
  it_behaves_like 'abusable'

  # Relations
  describe 'relations' do
    it { should belong_to(:owner).class_name('User') }
    it { should have_many(:contributions).dependent(:destroy) }
    it { should have_many(:contributors).through(:contributions).class_name('User') }
    it { should have_many(:invitations) }
    it { should belong_to(:receiver) }
    it { should have_many(:guests).through(:invitations).class_name('User') }
  end

  # Attributes
  it { is_expected.to monetize(:upper_bound).allow_nil }

  # DB
  it { should have_db_index(:owner_id) }
  it { should have_db_index(:receiver_id) }

  # Scope
  describe 'this_week' do
    it 'should return pots created last week' do
      pot = create(:pot)
      expect(Pot.this_week).to include(pot)
    end
    it 'should not return pots create before last week' do
      pot = create(:pot, :closed)
      expect(Pot.this_week).not_to include(pot)
    end
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:owner) }
    it { should validate_presence_of(:end_at) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:receiver) }
    it { should validate_uniqueness_of(:name) }

    describe 'should be' do
      let(:pot) { build(:pot, owner: @user) }

      it 'valid if owner\'s pot count <= 2' do
        @user = create(:user)
        expect(pot).to be_valid
      end
      it 'invalid if owner\'s pot count > 2' do
        @user = create(:user, :with_pot)
        create(:pot, owner: @user)
        last_pot = create(:pot, owner: @user)
        expect(last_pot).not_to be_valid
      end
      it "valid if owner's inactive pot count >= 2" do
        @user = create(:user, :with_closed_pots)
        expect(pot).to be_valid
      end
    end

    describe 'should be' do
      let(:pot) { build(:pot, owner: @user) }

      it 'valid if owner has less then 4 pots this year' do
        @user = create(:user)
        expect(pot).to be_valid
      end

      it 'invalid if owner has more then 4 pots this year' do
        @user = create(:user)
        create_list(:pot, 4, :closed, owner: @user)
        last_pot = create(:pot, owner: @user)
        expect(last_pot.valid?).to eq false
      end
    end

    describe 'should validate that the receiver' do
      let(:pot) { create(:pot) }

      it 'can not be a guest' do
        pot.guests << pot.receiver
        expect(pot.valid?).to eq false
      end

      it 'is not a guest' do
        expect(pot.valid?).to eq true
      end
    end

    describe "should validate that the receiver's PayPal account's country allows opotto" do
      it 'and allow if from NL' do
        user = create(:user, paypal_country: 'NL')
        pot = build(:pot, owner: user)
        expect(pot).to be_valid
      end

      it 'and deny if from JP' do
        user = create(:user, paypal_country: 'JP')
        pot = build(:pot, owner: user)
        expect(pot).not_to be_valid
      end
    end

    describe 'should validate that end_at' do
      it 'is in the future' do
        pot = build(:pot, end_at: 10.days.ago)
        expect(pot.valid?).to eq false
      end

      it 'is in the future not more then 90 days' do
        pot = build(:pot, end_at: 91.days.from_now)
        expect(pot.valid?).to eq false
      end

      it 'is in the future not more then 90 days' do
        pot = build(:pot, end_at: 10.days.from_now)
        expect(pot.valid?).to eq true
      end
    end

    describe 'should validate immutable' do
      let(:mock) { create(:pot, :with_guests, :with_description, :with_upper_bound) }

      Pot::IMMUTABLE.each do |immutable_attr|
        it immutable_attr.to_s do
          pot = create(:pot)
          pot.send("#{immutable_attr}=", mock.send(immutable_attr))
          expect(pot.valid?).to eq false
        end
      end
    end
  end

  # Instenace methods
  describe '#' do
    describe 'open?' do
      it 'returns true if end_at in future' do
        pot = create(:pot, :open)
        expect(pot.open?).to eq true
      end

      it 'returns false if ended' do
        pot = create(:pot, :ended)
        expect(pot.open?).to eq false
      end
    end

    describe 'ended?' do
      it 'returns true if ended' do
        pot = create(:pot, :ended)
        expect(pot.ended?).to eq true
      end

      it 'returns false if closed' do
        pot = create(:pot, :closed)
        expect(pot.ended?).to eq false
      end
    end

    describe 'closed?' do
      it 'returns false if open' do
        pot = create(:pot, :open)
        expect(pot.closed?).to eq false
      end

      it 'returns true if closed' do
        pot = create(:pot, :closed)
        expect(pot.closed?).to eq true
      end
    end

    describe 'total_contribution' do
      it 'should return 0 if no contributions' do
        pot = create(:pot)
        expect(pot.total_contribution).to eq 0
      end

      it 'should return the sum of contributions if contributions' do
        pot = create(:pot, :with_contributions)
        expect(pot.total_contribution).to eq pot.contributions.with_states(:scheduled, :completed).map(&:amount).inject { |a, e| a + e }
      end
    end

    describe 'total_contributors' do
      it 'should return 0 if no contributors' do
        pot = create(:pot)
        expect(pot.total_contributors).to eq 0
      end

      it 'should return the number of contributors if contributors' do
        pot = create(:pot, :with_contributions)
        expect(pot.total_contributors).to eq pot.contributors.count
      end
    end

    describe 'total_guests' do
      it 'should return 0 if no guests' do
        pot = create(:pot)
        expect(pot.total_guests).to eq 0
      end

      it 'should return the number of guests if guests' do
        pot = create(:pot, :with_guests)
        expect(pot.total_guests).to eq pot.guests.count
      end
    end
  end

  # Class methods
  describe '.' do
    it 'policy_class' do
      expect(Pot.policy_class).to be(PotPolicy)
    end
    describe 'open' do
      it 'should return only open pots' do
        create_list(:pot, 2, :open)
        closed_pots = create_list(:pot, 2, :closed)
        expect(Pot.open).not_to include closed_pots
      end
    end

    describe 'closed' do
      it 'should return only closed pots' do
        open_pots = create_list(:pot, 2, :open)
        create_list(:pot, 2, :closed)
        expect(Pot.closed).not_to include open_pots
      end
    end

    describe 'visible' do
      it 'should return only visible pots' do
        visible_pot = create(:pot, :visible)
        create_list(:pot, 2, visible: false)
        expect(Pot.visible).to include(visible_pot)
      end
    end

    describe 'ended' do
      it 'should return only ended pots' do
        ended_pot = create_list(:pot, 2, :ended)
        create_list(:pot, 2)
        expect(Pot.ended).to match_array(ended_pot)
      end
    end
  end
end
