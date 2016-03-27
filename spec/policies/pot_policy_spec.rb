require 'rails_helper'

describe PotPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:guest) { create(:user) }
  let(:stranger) { create(:user) }
  let(:pot) { create(:pot, owner: user, guests: [guest]) }

  permissions :show? do
    describe 'for visible pot' do
      before :each do
        pot.update_attribute(:visible, true)
      end
      it 'allows access to owner' do
        expect(subject).to permit(user, pot)
      end

      it "allows access to pot's guest" do
        expect(subject).to permit(guest, pot)
      end

      it 'allows access to users' do
        expect(subject).to permit(stranger, pot)
      end

      it 'denies access to guests' do
        expect(subject).not_to permit(nil, pot)
      end
    end
    describe 'for invisible pot' do
      before :each do
        pot.update_attribute(:visible, false)
      end
      it 'allows access to owner' do
        expect(subject).to permit(user, pot)
      end

      it "allows access to pot's guest" do
        expect(subject).to permit(guest, pot)
      end

      it 'denies access to users' do
        expect(subject).not_to permit(stranger, pot)
      end

      it 'denies access to guests' do
        expect(subject).not_to permit(nil, pot)
      end
    end
  end

  permissions :edit? do
    it 'allows access to owner' do
      expect(subject).to permit(user, pot)
    end

    it 'denies access to members' do
      expect(subject).not_to permit(create(:user), pot)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, pot)
    end
  end

  permissions :update? do
    it 'allows access to owner' do
      expect(subject).to permit(user, pot)
    end

    it 'denies access to members' do
      expect(subject).not_to permit(create(:user), pot)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, pot)
    end
  end

  permissions :contribute? do
    it 'allows access to owner' do
      expect(subject).to permit(user, pot)
    end

    it 'allows access to guests' do
      expect(subject).to permit(guest, pot)
    end

    it 'allow access to members' do
      expect(subject).to permit(create(:user), pot)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, pot)
    end
  end
end
