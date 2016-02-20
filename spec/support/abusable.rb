shared_examples 'abusable' do
  let(:jar) { create(:jar) }

  describe '#' do
    describe 'abuse?' do
      it 'should return true if has a confirmed abuse' do
        expect(jar.abuse?).to be(false)
      end

      it 'should return false if has no confirmed abuses' do
        jar.reported_abuses << create(:abuse, confirmed: true)
        expect(jar.abuse?).to be(true)
      end
    end
  end
end
