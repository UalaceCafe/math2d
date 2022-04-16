# frozen_string_literal: true

RSpec.describe Vector2D do
  subject { Vector2D.new x, y }
  let(:x) { 1 }
  let(:y) { 1 }

  shared_examples 'test unary' do |method, x, y, result|
    context "for vec(#{x}, #{y})" do
      let(:x) { x }
      let(:y) { y }
      it 'succeeds' do
        expect(subject.send(method)).to eq(result)
      end
    end
  end

  shared_examples 'test reverse' do |x, y|
    include_examples 'test unary', :reverse, x, y, Vector2D.new(-x, -y)
  end

  describe '#reverse' do
    include_examples 'test reverse', 1, 1
    include_examples 'test reverse', 3, 5
    include_examples 'test reverse', -3, 5
    include_examples 'test reverse', 3, -15
  end

  shared_examples 'test magnitude for' do |x, y, magnitude2|
    include_examples 'test unary', :magnitude, x, y, Math.sqrt(magnitude2)
  end

  describe '#magnitude' do
    include_examples 'test magnitude for', 1, 1, 2
    include_examples 'test magnitude for', 2, 2, (4 + 4)
    include_examples 'test magnitude for', 3, 3, (9 + 9)
  end

  shared_examples 'test magnitude2 for' do |x, y, magnitude2|
    include_examples 'test unary', :magnitude2, x, y, magnitude2
  end

  describe '#magnitude2' do
    include_examples 'test magnitude2 for', 1, 1, 2
    include_examples 'test magnitude2 for', 2, 2, (4 + 4)
    include_examples 'test magnitude2 for', 3, 3, (9 + 9)
  end

  shared_examples 'test ratio for' do |x, y|
    include_examples 'test unary', :ratio, x, y, x.to_f / y
  end

  describe '#ratio' do
    include_examples 'test ratio for', 1, 1
    include_examples 'test ratio for', 2, 2
    include_examples 'test ratio for', 3, 3
  end

  shared_examples 'test perpendicular for' do |x, y|
    include_examples 'test unary', :perp, x, y, Vector2D.new(y, -x)
  end

  describe '#perp' do
    include_examples 'test perpendicular for', 1, 1
    include_examples 'test perpendicular for', 2, 2
    include_examples 'test perpendicular for', 3, 3
  end
end
