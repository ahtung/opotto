require 'rails_helper'

RSpec.describe Abuse, type: :model do
  # Relations
  it { should belong_to(:resource) }

  # Instance methods
  describe 'confirm!' do
    let(:abuse) { build(:abuse) }

    it 'should set confirmed to true' do
      abuse.save
      abuse.confirm!
      expect(abuse.confirmed?).to be(true)
    end

    it 'should not set confirmed if new_record?' do
      abuse.confirm!
      abuse.restore_attributes([:confirmed])
      expect(abuse.confirmed?).to be(false)
    end
  end

  # Class methods
  describe '.' do
    describe 'confirmed' do
      it 'should return all confirmed abuses' do
        abuse = create(:abuse, confirmed: true)
        expect(Abuse.confirmed).to include(abuse)
      end

      it 'should not return pendong abuses' do
        abuse = create(:abuse)
        expect(Abuse.confirmed).not_to include(abuse)
      end
    end

    describe 'pending' do
      it 'should return pending abuses' do
        abuse = create(:abuse)
        expect(Abuse.pending).to include(abuse)
      end

      it 'should not return confirmed abuses' do
        abuse = create(:abuse, confirmed: true)
        expect(Abuse.pending).not_to include(abuse)
      end
    end
  end
end
