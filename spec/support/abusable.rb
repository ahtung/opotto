shared_examples 'abusable' do
  let(:pot) { create(:pot) }

  describe '#' do
    describe 'abuse?' do
      it 'should return true if has a confirmed abuse' do
        expect(pot.abuse?).to be(false)
      end

      it 'should return false if has no confirmed abuses' do
        pot.reported_abuses << create(:abuse, confirmed: true)
        expect(pot.abuse?).to be(true)
      end
    end
  end
end
