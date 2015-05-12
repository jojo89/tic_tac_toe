require 'spec_helper.rb'

describe Grid do
  subject { Grid.new(3) }
  let(:ex) { cell = Cell.new; cell.mark("|x|") ; cell}
  let(:oh) { cell = Cell.new; cell.mark("|o|") ; cell}

  describe "#board_completed?" do
    context "when the board is full and the game is not won" do
      before do
        allow(subject).to receive(:game_won?).and_return(false)
        allow(subject).to receive(:squares_occupied).and_return(9)
      end

      it "returns true" do
        expect(subject.board_completed?(nil, nil, nil)).to eq(true)
      end
    end

    context "when the games has been won" do
      let(:layout) {
        [
          [Cell.new, Cell.new, oh],
          [Cell.new, oh,       ex],
          [oh      , ex,       ex],
        ]  
      }

      before do
        allow(subject).to receive(:game_won?).and_return(true)
      end

      it "returns true" do
        expect(subject.board_completed?(1, 1, "o")).to eq(true)
      end
    end

    context "when the board isn't full and the game hasn't been won" do
      let(:layout) {
        [
          [Cell.new, Cell.new, Cell.new],
          [Cell.new, oh,       ex],
          [oh      , ex,       ex],
        ]  
      }

      before do
        allow(subject).to receive(:layout).and_return(layout)
      end

      it "returns true" do
        expect(subject.board_completed?(1, 1, "x")).to eq(false)
      end
    end
  end

  describe "#mark" do
    let(:first_turn) { Turn.new(1, 1, "x") }
    let(:second_turn) { Turn.new(1, 1, "o") }
    let(:layout) { subject.send(:layout) }


    context "when the cell is unmarked" do
      before do
        subject.mark(first_turn)
      end

      it "marks the coordinates of the passed turn" do
        expect(layout[1][1].space).to eq("|x|")
      end
    end

    context "when the cell is marked" do
      before do
        subject.mark(first_turn)
        subject.mark(second_turn)
      end

      it "doesn't mark the coordinates of the passed turn" do
        expect(layout[1][1].space).to eq("|x|")
      end
    end
  end
end
