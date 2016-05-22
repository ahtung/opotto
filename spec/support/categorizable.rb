shared_examples 'categorizable' do
  let(:pot) { create(:pot) }

  it { should validate_presence_of(:category) }

  describe '#' do
    describe 'category_color' do
    end
  end
end
