# frozen_string_literal: true

require_relative "../lib/game"

describe Game do
  let(:player1) { instance_double("player1", name: "Player 1", marker: "X") }
  let(:player2) { instance_double("player2", name: "Player 2", marker: "O") }
  let(:display) { instance_double("Display") }
  let(:board) { instance_double("board") }
  subject(:basic_game) { described_class.new(display: display, board: board, player1: player1, player2: player2) }

  describe "#play_game" do
    before do
      allow(basic_game).to receive_messages(setup: nil, final_message: nil)
    end

    context "when game is over" do
      it "calls game_over only once" do
        allow(basic_game).to receive(:play_again?).and_return(nil)
        allow(board).to receive(:game_over?).and_return(true)
        expect(board).to receive(:game_over?).once
        basic_game.play_game
      end
    end

    context "when two rounds are played before game over" do
      it "calls game_over? three times before exiting" do
        allow(basic_game).to receive(:play_again?).and_return(nil)
        allow(basic_game).to receive(:play_one_round).and_return(nil)
        allow(board).to receive(:game_over?).and_return(false, false, true)
        expect(board).to receive(:game_over?).exactly(3).times
        basic_game.play_game
      end
    end

    context "when two rounds are played" do
      it "alternates players" do
        allow(basic_game).to receive(:play_again?).and_return(false)
        allow(board).to receive(:game_over?).and_return(false, false, true)
        expect(basic_game).to receive(:play_one_round).with(player1).once
        expect(basic_game).to receive(:play_one_round).with(player2).once
        basic_game.play_game
      end
    end

    context "when input is q" do
      it "breaks the loop" do
        allow(basic_game).to receive(:play_again?).and_return(nil)
        allow(board).to receive(:game_over?).and_return(false, false, true)
        allow(basic_game).to receive(:play_one_round).and_return("quit")
        expect(basic_game).to receive(:play_one_round).once
        basic_game.play_game
      end
    end

    context "when playing again" do
      it "calls reset_game" do
        allow(board).to receive_messages(setup: nil, game_over?: true)
        allow(basic_game).to receive(:play_again?).and_return(true)
        expect(basic_game).to receive(:reset_game).once
        basic_game.play_game
      end
    end

    context "when not playing again" do
      it "does not call reset_game" do
        allow(board).to receive_messages(setup: nil, game_over?: true)
        allow(basic_game).to receive(:play_again?).and_return(false)
        expect(basic_game).not_to receive(:reset_game)
        basic_game.play_game
      end
    end
  end

  describe "#play_one_round" do
    context "when player inputs q" do
      it "returns without calling update_board" do
        allow(board).to receive(:available_columns)
        allow(player1).to receive(:player_turn).and_return("q")
        expect(board).not_to receive(:update_board)
        basic_game.play_one_round(player1)
      end
    end

    context "when player provides valid input" do
      it "calls calls update_board with the correct column and marker" do
        valid_input = "3"
        allow(board).to receive(:available_columns)
        allow(player2).to receive(:player_turn).and_return(valid_input)
        allow(basic_game).to receive(:show_board).and_return(nil)
        expect(board).to receive(:update_board).with("3", "O")
        basic_game.play_one_round(player2)
      end
    end
  end

  describe "#final_message" do
    context "when the game is tied" do
      it "shows the tie message" do
        tie_phrase = "The game was tied.\nThanks for playing!\n"
        allow(board).to receive(:winner).and_return("")
        expect { basic_game.final_message }.to output(tie_phrase).to_stdout
      end
    end

    context "when player1 wins" do
      it "states player1 won" do
        player1_phrase = "#{player1.name} won!\nThanks for playing!\n"
        allow(board).to receive(:winner).and_return("X")
        expect { basic_game.final_message }.to output(player1_phrase).to_stdout
      end
    end

    context "when player2 wins" do
      it "states player2 won" do
        player2_phrase = "#{player2.name} won!\nThanks for playing!\n"
        allow(board).to receive(:winner).and_return("O")
        expect { basic_game.final_message }.to output(player2_phrase).to_stdout
      end
    end
  end

  describe "#play_again?" do
    it "sends request_input" do
      expect(basic_game).to receive(:request_input).once
      basic_game.play_again?
    end
  end

  describe "#show_board" do
    it "calls create_visual_board" do
      allow(board).to receive(:gameboard_columns).and_return([])
      allow(basic_game).to receive(:puts)
      allow(display).to receive(:clear_terminal)
      expect(display).to receive(:create_visual_board).with(Array).once
      basic_game.show_board
    end
  end
end
