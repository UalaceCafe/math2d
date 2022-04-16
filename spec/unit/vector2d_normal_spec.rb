# frozen_string_literal: true

require 'matrix'

RSpec.describe Vector2D do
  subject { Vector2D.new x, y }
  let(:x) { 10 }
  let(:y) { 10 }

  describe '#normalize' do
    let(:result) { subject.normalize }
    it 'returns new vector' do
      expect(result).not_to eq subject
    end

    it 'magnitude is 1' do
      # Use Rubt std lib to test
      expect(Vector[result.x, result.y].norm.round(MAXPRECISION)).to eq 1
    end
  end

  describe '#normalize!' do
    let(:result) { subject.normalize! }
    it 'modified vector in place' do
      expect(result).to eq subject
    end

    it 'magnitude is 1' do
      # Use Rubt std lib to test
      expect(Vector[result.x, result.y].norm.round(MAXPRECISION)).to eq 1
    end
  end
end
