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
      xit 'should call success! if complete_payment' do
        contribution.update_attribute(:preapproval_key, 'GOOD_KEY')
        expect(contribution).to receive(:success!)
        contribution.complete_payment
      end
      it 'should call fail! unless complete_payment' do
        contribution.update_attribute(:preapproval_key, 'BAD_KEY')
        expect(contribution).to receive(:error!)
        contribution.complete_payment
      end
    end
  end
end
