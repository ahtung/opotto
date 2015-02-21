require 'rails_helper'

describe Jar do
  it { should belong_to(:owner).class_name('User') }
  it { should have_many(:contributions).dependent(:destroy) }
  it { should have_many(:contributors).through(:contributions).class_name('User') }
  it { should have_many(:invitations) }
  it { should have_many(:guests).through(:invitations).class_name('User') }

  it { should validate_presence_of(:end_at) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it 'should validate that the end_at is in the future' do
    jar = build(:jar, end_at: 10.days.ago)
    expect(jar.valid?).to eq false
  end

  describe '#total_contribution' do
    it 'should return 0 if no contributions' do
      jar = create(:jar)
      expect(jar.total_contribution).to eq 0
    end

    it 'should return the sum of contributions if contributions' do
      jar = create(:jar, :with_contributions)
      expect(jar.total_contribution).to eq jar.contributions.map(&:amount).inject { |sum, x| sum + x }
    end
  end

  describe '#total_contributors' do
    it 'should return 0 if no contributors' do
      jar = create(:jar)
      expect(jar.total_contributors).to eq 0
    end

    it 'should return the number of contributors if contributors' do
      jar = create(:jar, :with_contributions)
      expect(jar.total_contributors).to eq jar.contributors.count
    end
  end

  describe '#total_guests' do
    it 'should return 0 if no guests' do
      jar = create(:jar)
      expect(jar.total_guests).to eq 0
    end

    it 'should return the number of guests if guests' do
      jar = create(:jar, :with_guests)
      expect(jar.total_guests).to eq jar.guests.count
    end
  end
end
