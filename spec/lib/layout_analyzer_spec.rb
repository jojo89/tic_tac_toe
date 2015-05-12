require 'spec_helper.rb'

RSpec.shared_examples "completed_board" do
  before do
    allow(subject).to receive(:layout).and_return(layout)
  end

  context "with a turn that doesn't win the game " do
    it "returns nil" do
      expect(subject.three_in_a_row?(1, 2)).to eq(false)
    end
  end

  context "with a turn that wins the game " do
    it "it returns true" do
      expect(subject.three_in_a_row?(1, 1)).to eq(true)
    end
  end
end

describe LayoutAnalyzer do
  subject { described_class.new(3) }
  let(:ex) { cell = Cell.new; cell.mark("|x|") ; cell}
  let(:oh) { cell = Cell.new; cell.mark("|o|") ; cell}

  before do
    allow(subject).to receive(:layout).and_return(layout)
  end

  describe "#create_turn?" do

    context "when the opposing team has a potential win" do
      let(:layout) {
        [
          [Cell.new, Cell.new, oh],
          [Cell.new, Cell.new, ex],
          [oh      , ex,       ex],
        ]  
      }

      it "returns a blocking turn" do
        expect(subject.create_turn("x").row).to eq(1)
        expect(subject.create_turn("x").column).to eq(1)
      end
    end

    context "when team has a potential win" do
      let(:layout) {
        [
          [oh,       Cell.new, Cell.new],
          [Cell.new, ex,       ex],
          [oh      , Cell.new, ex],
        ]  
      }

      it "returns a winning turn" do
        expect(subject.create_turn("x").row).to eq(0)
        expect(subject.create_turn("x").column).to eq(2)
      end
    end
  end
  
  describe "#board_completed?" do
    context "diagnol forward" do
      let(:layout) {
        [
          [Cell.new, Cell.new, oh],
          [Cell.new, oh,       ex],
          [oh      , ex,       ex],
        ]  
      }
    
      it_behaves_like "completed_board"
    end

    context "diagnol backword" do
      let(:layout) {
        [
          [oh,       Cell.new, ex],
          [Cell.new, oh,       ex],
          [ex      , ex,       oh],
        ]
     }
     it_behaves_like "completed_board"
   
    end

    context "vertical" do
      let(:layout) {
        [
          [oh,       oh, ex      ],
          [Cell.new, oh, ex      ],
          [ex      , oh, Cell.new],
        ]  
     }
     it_behaves_like "completed_board"
    end

    context "horizontal" do
      let(:turn) { Turn.new(0, 2, "o") }
      let(:layout) {
        [
          [oh,       oh, oh      ],
          [Cell.new, oh, ex      ],
          [ex      , oh, Cell.new],
        ]  
     }
     it_behaves_like "completed_board"
    end
  end
end
