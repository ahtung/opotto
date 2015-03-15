require 'rails_helper'

describe Jar, focus: true do
  # Relations
  describe 'relations' do
    it { should belong_to(:owner).class_name('User') }
    it { should have_many(:contributions).dependent(:destroy) }
    it { should have_many(:contributors).through(:contributions).class_name('User') }
    it { should have_many(:invitations) }
    it { should belong_to(:receiver) }
    it { should have_many(:guests).through(:invitations).class_name('User') }
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:end_at) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:receiver) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'should validate that the receiver' do
    let(:jar) { create(:jar) }

    it 'can not be a guest' do
      jar.guests << jar.receiver
      expect(jar.valid?).to eq false
    end

    it 'is not a guest' do
      expect(jar.valid?).to eq true
    end
  end

  it 'should validate that the end_at is in the future' do
    jar = build(:jar, end_at: 10.days.ago)
    expect(jar.valid?).to eq false
  end

  it 'should validate that the end_at is in the future' do
    jar = build(:jar, end_at: 10.days.ago)
    expect(jar.valid?).to eq false
  end

  # Instenace methods
  describe '#' do
    describe 'fullness' do
      it 'should return 0 if no contributions' do
        jar = create(:jar)
        expect(jar.fullness).to eq 0
      end

      it 'should return x if no contributions' do
        jar = create(:jar, :with_contributions)
        expect(jar.fullness).to eq jar.contributions.map(&:amount).inject { |sum, x| sum + x } / 1000
      end
    end

    describe 'total_contribution' do
      it 'should return 0 if no contributions' do
        jar = create(:jar)
        expect(jar.total_contribution).to eq 0
      end

      it 'should return the sum of contributions if contributions' do
        jar = create(:jar, :with_contributions)
        expect(jar.total_contribution).to eq jar.contributions.map(&:amount).inject { |sum, x| sum + x }
      end
    end

    describe 'total_contributors' do
      it 'should return 0 if no contributors' do
        jar = create(:jar)
        expect(jar.total_contributors).to eq 0
      end

      it 'should return the number of contributors if contributors' do
        jar = create(:jar, :with_contributions)
        expect(jar.total_contributors).to eq jar.contributors.count
      end
    end

    describe 'total_guests' do
      it 'should return 0 if no guests' do
        jar = create(:jar)
        expect(jar.total_guests).to eq 0
      end

      it 'should return the number of guests if guests' do
        jar = create(:jar, :with_guests)
        expect(jar.total_guests).to eq jar.guests.count
      end
    end

    describe 'pot_points' do
      let(:jar) { create(:jar, :with_contributions) }

      it 'should return a array of length 12' do
        expect(jar.pot_points.count).to eq(12)
      end

      describe 'should return a array of where item is a hash' do
        let(:points) { jar.pot_points }
        it 'with key x' do
          expect(points.first.has_key?(:x)).to be(true)
        end
        it 'with key y' do
          expect(points.first.has_key?(:y)).to be(true)
        end
      end
    end
  end

  # Class methods
  describe '.' do
    describe 'open' do
      it 'should return only open pots' do
        create_list(:jar, 2, :open)
        closed_jars = create_list(:jar, 2, :closed)
        expect(Jar.open).not_to include closed_jars
      end
    end

    describe 'closed' do
      it 'should return only closed pots' do
        open_jars = create_list(:jar, 2, :open)
        create_list(:jar, 2, :closed)
        expect(Jar.closed).not_to include open_jars
      end
    end

    describe 'visible' do
      it 'should return only visible pots' do
        visible_jars = create_list(:jar, 2, :visible)
        create_list(:jar, 2)
        expect(Jar.visible).to match_array(visible_jars)
      end
    end

    describe 'ended' do
      it 'should return only ended pots' do
        ended_jar = create_list(:jar, 2, :ended)
        create_list(:jar, 2)
        expect(Jar.ended).to match_array(ended_jar)
      end
    end
  end
end
