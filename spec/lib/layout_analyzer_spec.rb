require 'spec_helper.rb'

RSpec.shared_examples "completed_board" do
  subject { described_class.new(3) }
  let(:ex) { cell = Cell.new; cell.mark("|x|") ; cell}
  let(:oh) { cell = Cell.new; cell.mark("|o|") ; cell}

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
