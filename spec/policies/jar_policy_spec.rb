require 'rails_helper'

describe JarPolicy, focus: true do
  subject { described_class }

  let(:user) { create(:user) }
  let(:guest) { create(:user) }
  let(:jar) { create(:jar, owner: user, guests: [guest]) }

  permissions :show? do
    describe 'for visible jar' do
      before :each do
        jar.update_attribute(:visible, true)
      end
      it 'allows access to owner' do
        expect(subject).to permit(user, jar)
      end

      it "allows access to jar's guest" do
        expect(subject).to permit(guest, jar)
      end

      it 'allows access to users' do
        expect(subject).to permit(user, jar)
      end

      it 'denies access to guests' do
        expect(subject).not_to permit(nil, jar)
      end
    end
    describe 'for invisible jar' do
      before :each do
        jar.update_attribute(:visible, false)
      end
      it 'allows access to owner' do
        expect(subject).to permit(user, jar)
      end

      it "allows access to jar's guest" do
        expect(subject).to permit(guest, jar)
      end

      it 'denies access to users' do
        expect(subject).not_to permit(user, jar)
      end

      it 'denies access to guests' do
        expect(subject).not_to permit(nil, jar)
      end
    end
  end

  permissions :new? do
    it 'allows access to members' do
      expect(subject).to permit(user, jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end

  permissions :create? do
    it 'allows access to members' do
      expect(subject).to permit(user, jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end

  permissions :edit? do
    it 'allows access to owner' do
      expect(subject).to permit(user, jar)
    end

    it 'denies access to members' do
      expect(subject).not_to permit(create(:user), jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end

  permissions :update? do
    it 'allows access to owner' do
      expect(subject).to permit(user, jar)
    end

    it 'denies access to members' do
      expect(subject).not_to permit(create(:user), jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end

  permissions :contribute? do
    it 'allows access to owner' do
      expect(subject).to permit(user, jar)
    end

    it 'allows access to guests' do
      expect(subject).to permit(guest, jar)
    end

    it 'allow access to members' do
      expect(subject).to permit(create(:user), jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end
end