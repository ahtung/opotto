require 'rails_helper'

RSpec.describe PotPolicy, focus: true do
  subject { described_class }

  let(:user) { create(:user) }
  let(:guest) { create(:user) }
  let(:stranger) { create(:user) }

  permissions :show? do
    it 'allows access to owner' do
      pot = create(:pot, owner: user)
      expect(subject).to permit(user, pot)
    end

    it "allows access to pot's guest" do
      pot = create(:pot, guests: [guest])
      expect(subject).to permit(guest, pot)
    end

    it 'allows access to users if visible' do
      pot = create(:pot, visible: true)
      expect(subject).to permit(stranger, pot)
    end

    it 'denies access to users unless visible' do
      pot = create(:pot, visible: false)
      expect(subject).not_to permit(stranger, pot)
    end

    it 'denies access to guests' do
      pot = create(:pot)
      expect(subject).not_to permit(nil, pot)
    end
  end

  permissions :edit? do
    it 'allows access to owner' do
      pot = create(:pot, owner: user)
      expect(subject).to permit(user, pot)
    end

    it "denies access to pot's guest" do
      pot = create(:pot, guests: [guest])
      expect(subject).not_to permit(guest, pot)
    end

    it 'allows access to users' do
      pot = create(:pot)
      expect(subject).not_to permit(stranger, pot)
    end

    it 'denies access to guests' do
      pot = create(:pot)
      expect(subject).not_to permit(nil, pot)
    end
  end

  permissions :update? do
    it 'allows access to owner' do
      pot = create(:pot, owner: user)
      expect(subject).to permit(user, pot)
    end

    it "denies access to pot's guest" do
      pot = create(:pot, guests: [guest])
      expect(subject).not_to permit(guest, pot)
    end

    it 'allows access to users' do
      pot = create(:pot)
      expect(subject).not_to permit(stranger, pot)
    end

    it 'denies access to guests' do
      pot = create(:pot)
      expect(subject).not_to permit(nil, pot)
    end
  end

  permissions :contribute? do
    it 'allows access to owner' do
      pot = create(:pot, owner: user)
      expect(subject).to permit(user, pot)
    end

    it "allows access to pot's guest" do
      pot = create(:pot, guests: [guest])
      expect(subject).to permit(guest, pot)
    end

    it 'allows access to users if visible' do
      pot = create(:pot, visible: true)
      expect(subject).to permit(stranger, pot)
    end

    it 'denies access to users unless visible' do
      pot = create(:pot, visible: false)
      expect(subject).not_to permit(stranger, pot)
    end

    it 'denies access to guests' do
      pot = create(:pot)
      expect(subject).not_to permit(nil, pot)
    end
  end
end
