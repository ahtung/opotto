shared_examples 'payable' do
  let(:contribution) { create(:contribution, state: :scheduled) }

  describe '#' do
    describe 'pay' do
      it 'updates preapproval_key column' do
        contribution.pay
        expect(contribution.preapproval_key).not_to eq(nil)
      end

      it 'updates authorization_url attr_accessor' do
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
      it 'should call success! if complete_payment' do
        contribution.update_attribute(:preapproval_key, 'GOOD_KEY')
        expect(contribution).to receive(:success!)
        contribution.complete_payment
      end
      xit 'should call fail! unless complete_payment' do
        contribution.update_attribute(:preapproval_key, 'BAD_KEY')
        expect(contribution).to receive(:error!)
        contribution.complete_payment
      end
    end
  end
end
