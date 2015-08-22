shared_examples 'payable' do
  describe '#' do
    describe 'pay' do
    end
    describe 'complete' do
      it 'should call success! if complete_payment' do
        contribution = create(:contribution)
        expect(contribution).to receive(:success!)
        contribution.complete
      end
      xit 'should call fail! unless complete_payment' do
        contribution = create(:contribution)
        expect(contribution).to receive(:fail!)
        contribution.complete
      end
    end
    describe 'refund' do
    end
  end
end
