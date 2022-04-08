# frozen_string_literal: true

RSpec.describe Vector2D do
  subject { Vector2D.new x, y }
  let(:x) { 1 }
  let(:y) { 1 }

  describe '#limit' do
    let(:max) { 3 }
    let(:result) { subject.limit max }

    context 'when less than 3' do
      it 'succeeds' do
        expect(result.x).to eq(x)
        expect(result.y).to eq(y)
      end
    end

    context 'when greater than 3' do
      let(:x) { 3 }
      let(:y) { 3 }
      it 'succeeds' do
        expect(result.magnitude.round(MAXPRECISION)).to be <= 3
      end
    end
  end

  describe '#constrain' do
    let(:min) { 1 }
    let(:max) { 3 }
    let(:result) { subject.constrain min, max }

    context 'when within 0 and 3' do
      it 'succeeds' do
        expect(result.x).to eq(x)
        expect(result.y).to eq(y)
      end
    end

    context 'when greater than 3' do
      let(:x) { 3 }
      let(:y) { 3 }
      it 'succeeds' do
        expect(result.magnitude).to be <= 3
      end
    end

    context 'when less than 1' do
      let(:x) { 0.5 }
      let(:y) { 0.5 }
      it 'succeeds' do
        expect(result.magnitude.round(MAXPRECISION)).to be >= 1
      end
    end
  end
end
