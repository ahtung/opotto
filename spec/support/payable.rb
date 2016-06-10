shared_examples 'payable' do
  let(:contribution) { create(:contribution, state: :scheduled) }

  describe '#' do
    describe 'pay' do
    end

    describe 'payment_time' do
      it 'should return time left to payment' do
        Timecop.freeze(Time.zone.now) do
          expect(contribution.payment_time).to eq(864_000.0)
        end
      end
    end

    describe 'complete_payment' do
    end
  end
end
