shared_examples 'categorizable' do
  let(:pot) { create(:pot) }

  it { should validate_presence_of(:category) }

  describe '#' do
    describe 'category_color' do
      it 'should return red for home category' do
        pot = build(:pot, category: 'home')
        expect(pot.category_color).to eq('red')
      end

      it 'should return orange for sutudent category' do
        pot = build(:pot, category: 'student')
        expect(pot.category_color).to eq('orange')
      end

      it 'should return yellow for gift category' do
        pot = build(:pot, category: 'gift')
        expect(pot.category_color).to eq('yellow')
      end

      it 'should return olive for plane category' do
        pot = build(:pot, category: 'plane')
        expect(pot.category_color).to eq('olive')
      end

      it 'should return green for dieamond category' do
        pot = build(:pot, category: 'diamond')
        expect(pot.category_color).to eq('green')
      end

      it 'should return teal for truck category' do
        pot = build(:pot, category: 'truck')
        expect(pot.category_color).to eq('teal')
      end

      it 'should return blue for trophy category' do
        pot = build(:pot, category: 'trophy')
        expect(pot.category_color).to eq('blue')
      end

      it 'should return violet for heart category' do
        pot = build(:pot, category: 'heart')
        expect(pot.category_color).to eq('violet')
      end
    end
  end
end
