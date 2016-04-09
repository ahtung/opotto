require 'spec_helper'

RSpec.describe PotDecorator, type: :decorator do
  let(:pot) { nil }

  describe 'status' do
    context 'for open pot' do
      let(:pot) { create(:pot, :open).decorate }

      it 'should return a yellow label if open?' do
        expect(pot.status).to eq('<div class="card-panel yellow">Open</div>')
      end
    end

    context 'for closed pot' do
      let(:pot) { create(:pot, :closed).decorate }

      it 'should return a green label if ended?' do
        expect(pot.status).to eq('<div class="card-panel green">Closed</div>')
      end
    end

    context 'for ended pot' do
      let(:pot) { create(:pot, :ended).decorate }

      it 'should return a orange label if closed?' do
        expect(pot.status).to eq('<div class="card-panel orange">Ended</div>')
      end
    end
  end

  describe 'status_color' do
    context 'for open pot' do
      let(:pot) { create(:pot, :open).decorate }

      it 'should return a yellow label if open?' do
        expect(pot.status_color).to eq('yellow')
      end
    end

    context 'for closed pot' do
      let(:pot) { create(:pot, :closed).decorate }

      it 'should return a green label if ended?' do
        expect(pot.status_color).to eq('green')
      end
    end

    context 'for ended pot' do
      let(:pot) { create(:pot, :ended).decorate }

      it 'should return a orange label if closed?' do
        expect(pot.status_color).to eq('orange')
      end
    end
  end

  describe 'status_text' do
    context 'for open pot' do
      let(:pot) { create(:pot, :open).decorate }

      it 'should return Open' do
        expect(pot.status_text).to eq('Open')
      end
    end

    context 'for closed pot' do
      let(:pot) { create(:pot, :closed).decorate }

      it 'should return Closed' do
        expect(pot.status_text).to eq('Closed')
      end
    end

    context 'for ended pot' do
      let(:pot) { create(:pot, :ended).decorate }

      it 'should return Ended' do
        expect(pot.status_text).to eq('Ended')
      end
    end
  end
end
