require 'spec_helper.rb'

describe Game do
  subject { Game.new("x", 3) }
  let(:turn) { Turn.new(1, 1, "x") }
  let!(:starting_player) { subject.send(:current_player) }
  let(:layout) { subject.send(:grid).layout }

  describe "#start_game" do
    before do
      allow(subject).to receive(:finished?).and_return(true)
      allow(subject).to receive(:generate_user_turn).and_return(turn)
      allow(subject).to receive(:generate_computer_turn).and_return(turn)
      subject.start_game
    end

    it "changes the current player" do
      expect(subject.send(:current_player)).to_not eq(starting_player)
    end

    it "it marks the grid with the correct piece" do
      expect(layout[1][1]).to be_marked
    end
  end
end