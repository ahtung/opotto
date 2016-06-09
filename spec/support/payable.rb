shared_examples 'payable' do
  let(:contribution) { create(:contribution, state: :scheduled) }

  describe '#' do
    describe 'pay' do
      it 'updates preapproval_key column' do
        contribution.pay
        expect(contribution.preapproval_key).not_to eq(nil)
      end

      xit 'updates authorization_url attr_accessor' do
        contribution.pay
        expect(contribution.authorization_url).not_to eq(nil)
      end
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
