# frozen_string_literal: true

require_relative "../lib/game"

describe Game do
  let(:player1) { instance_double("player1", name: "Player 1", marker: "X") }
  let(:player2) { instance_double("player2", name: "Player 2", marker: "O") }
  let(:board) { instance_double("board") }
  subject(:basic_game) { described_class.new(board, player1, player2) }

  describe "#play_game" do
    before do
      allow(basic_game).to receive_messages(final_message: nil)
    end

    context "when game is over" do
      it "calls game_over only once" do
        allow(board).to receive(:game_over?).and_return(true)
        expect(board).to receive(:game_over?).once
        basic_game.play_game
      end
    end

    context "when two rounds are played before game over" do
      it "calls game_over? three times before exiting" do
        allow(basic_game).to receive(:play_one_round).and_return(nil)
        allow(board).to receive(:game_over?).and_return(false, false, true)
        expect(board).to receive(:game_over?).exactly(3).times
        basic_game.play_game
      end
    end

    context "when two rounds are played" do
      it "alternates players" do
        allow(board).to receive(:game_over?).and_return(false, false, true)
        expect(basic_game).to receive(:play_one_round).with(player1)
        expect(basic_game).to receive(:play_one_round).with(player2)
        basic_game.play_game
      end
    end

    context "when input is q" do
      it "breaks the loop" do
        allow(board).to receive(:game_over?).and_return(false, false, true)
        allow(basic_game).to receive(:play_one_round).and_return("quit")
        expect(basic_game).to receive(:play_one_round).once
        basic_game.play_game
      end
    end
  end
end
