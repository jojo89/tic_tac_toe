require 'spec_helper.rb'

describe Grid do
  subject { Grid.new(3) }
  let(:ex) { cell = Cell.new; cell.mark_ex ; cell}
  let(:oh) { cell = Cell.new; cell.mark_oh ; cell}
    let(:grid) {
      [
        [Cell.new, Cell.new, oh],
        [Cell.new, oh, ex],
        [oh, ex, ex],
      ]  
   }

    before do
      allow(subject).to receive(:grid).and_return(grid)
    end

  describe "#lean_forward" do
    context "when the last cell " do
      it "" do
        expect(subject.lean_forward(2, 2, "|x|")).to be_nil
      end

      it "" do
        expect(subject.lean_forward(1, 1, "|o|")).to eq(true)
      end
    end
  end

  describe "#up_right" do
    context "when the last cell " do
      it "" do
        expect(subject.up_right(1, 1, "|x|")).to be(false)
      end

      it "" do
        expect(subject.up_right(0, 2, "|o|")).to eq(true)
      end
    end
  end
end
