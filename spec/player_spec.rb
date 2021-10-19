# frozen_string_literal: true

# frozen_string_literal: true

require_relative "../lib/player"

describe Player do
  let(:board_double) { instance_double("Board") }

  describe "#verify_input" do
    subject(:verify_game) { described_class.new }
    let(:choices) { %w[2 3 4 6 q] }

    context "when a valid choice is entered" do
      let(:player_input) { "2" }
      it "returns the valid choice" do
        expect(verify_game.verify_input(player_input, choices)).to eq("2")
      end
    end

    context "when input is q" do
      let(:user_input) { "q" }
      it "returns q" do
        expect(verify_game.verify_input(user_input, choices)).to eq("q")
      end
    end
    context "when invalid choice is entered" do
      let(:user_input) { "1" }
      it "returns nil" do
        expect(verify_game.verify_input(user_input, choices)).to be_nil
      end
    end

    context "when letter that is not q is entered" do
      let(:user_input) { "d" }
      it "returns nil" do
        expect(verify_game.verify_input(user_input, choices)).to be_nil
      end
    end

    context "when multi-digit number entered" do
      let(:user_input) { "32" }
      it "returns nil" do
        expect(verify_game.verify_input(user_input, choices)).to be_nil
      end
    end

    context "when digit and letter entered" do
      let(:user_input) { "5a" }
      it "returns nil" do
        expect(verify_game.verify_input(user_input, choices)).to be_nil
      end
    end
  end

  describe "#player_turn" do
    subject(:player_loop) { described_class.new }
    let(:choices) { %w[1 2 3 4 7] }
    let(:choices1) { %w[2 3 4 6 7] }

    context "when user input is valid" do
      it "stops loop and does not recieve error message" do
        valid_input = "3"
        allow(player_loop).to receive(:player_input).and_return(valid_input)
        expect(player_loop).not_to receive(:puts).with("Input Error! Please use one of the following choices: 1, 2, 3, 4, 7, q")
        player_loop.player_turn(choices)
      end
    end

    context "when user input enters incorrect choice once, then a valid choice" do
      it "completes loops and displays error message once" do
        valid_input = "3"
        allow(player_loop).to receive(:player_input)
        allow(player_loop).to receive(:verify_input).and_return(nil, valid_input)
        expect(player_loop).to receive(:puts).with("Input Error! Please use one of the following choices: 2, 3, 4, 6, 7, q").once
        player_loop.player_turn(choices1)
      end
    end

    context "when user inputs two incorrect values, then a valid input" do
      it "completes loops and displays error message twice" do
        valid_input = "3"
        allow(player_loop).to receive(:player_input)
        allow(player_loop).to receive(:verify_input).and_return(nil, nil, valid_input)
        expect(player_loop).to receive(:puts).with("Input Error! Please use one of the following choices: 2, 3, 4, 6, 7, q").twice
        player_loop.player_turn(choices1)
      end
    end
  end
end
