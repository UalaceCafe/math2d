# frozen_string_literal: true

require 'matrix'

RSpec.describe Vector2D do
  subject { Vector2D.new x, y }
  let(:x) { 10 }
  let(:y) { 10 }
  let(:angle) { 90 }

  describe '#rotate' do
    let(:result) { subject.rotate(angle) }
    it 'returns new vector' do
      expect(result).not_to eq subject
    end
  end

  describe '#rotate!' do
    let(:result) { subject.rotate!(angle) }
    it 'modifies vector in place' do
      expect(result).to eq subject
    end
  end

  describe '#rotate_around' do
    let(:pivot) { Vector2D.one }
    let(:result) { subject.rotate_around(pivot, angle) }
    it 'returns new vector' do
      expect(result).not_to eq subject
    end
  end

  describe '#rotate_around!' do
    let(:pivot) { Vector2D.one }
    let(:result) { subject.rotate_around!(pivot, angle) }
    it 'modifies vector in place' do
      expect(result).to eq subject
    end
  end

  describe '#vector_cross_product (#perp)' do
    let(:result) { subject.vector_cross_product }
    it 'returns new vector' do
      expect(result).not_to eq subject
    end
  end

  describe '#vector_cross_product! (#perp!)' do
    let(:result) { subject.vector_cross_product! }
    it 'modifies vector in place' do
      expect(result).to eq subject
    end
  end
end
