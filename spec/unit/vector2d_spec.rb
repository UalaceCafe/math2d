# frozen_string_literal: true

RSpec.describe Vector2D do
  subject { Vector2D.new x, y }
  let(:x) { 1 }
  let(:y) { 1 }

  describe '#negate' do
    let(:result) { subject.negate }

    it 'succeeds' do
      expect(result.x).to eq(-x)
      expect(result.y).to eq(-y)
    end
  end
end
