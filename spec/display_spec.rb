# frozen_string_literal: true

require_relative "../lib/display"

describe Display do
  subject(:display) { described_class.new }

  describe "#update_view" do

  end

  describe "#update_markers" do
    let(:sample_array) { [%w[1 2 3 X O X], %w[1 X X X O O O]] }
    black_circle = "\u26ab"
    red_circle = "\u{1F534}"
    yellow_circle = "\u{1f7e1}"
    red_square = "\e[31;41m\u2b1b\e[0m"
    blue_square = "\e[36;46m\u2b1b\e[0m"
    grey_square = "\e[1;30;1;40m\u2b1b\e[0m"
    let(:updated_array) {
      [black_circle, black_circle, black_circle, red_circle, yellow_circle, red_circle,
       black_circle, red_circle, red_circle, red_circle, yellow_circle, yellow_circle, yellow_circle]
    }
    let(:home_array) {
      [grey_square, grey_square, grey_square, red_square, blue_square, red_square,
       grey_square, red_square, red_square, red_square, blue_square, blue_square, blue_square]
    }

    context "when marker is X and location is replit" do
      x_array = %w[X X]
      subject(:update_x) { described_class.new(board: x_array, location: "replit") }
      circle_array = [red_circle, red_circle]
      it "replaces it with a red circle" do
        expect(update_x.update_markers).to eq(circle_array)
      end
    end

    context "when marker is O and location is replit" do
      o_array = %w[O O]
      subject(:update_o) { described_class.new(board: o_array, location: "replit") }
      circle_array = [yellow_circle, yellow_circle]
      it "replaces it with a yellow circle" do
        expect(update_o.update_markers).to eq(circle_array)
      end
    end

    context "when marker is a number and location is replit" do
      number_array = %w[1 2]
      subject(:update_numbers) { described_class.new(board: number_array, location: "replit") }
      circle_array = [black_circle, black_circle]
      it "replaces it with a black circle" do
        expect(update_numbers.update_markers).to eq(circle_array)
      end
    end

    context "when multiple marker types and location is replit" do
      subject(:update_full_array) { described_class.new(board: sample_array, location: "replit") }
      it "replaces all markers correctly" do
        expect(update_full_array.update_markers).to eq(updated_array)
      end
    end

    context "when marker is X and location is default" do
      x_array = %w[X X]
      subject(:update_x) { described_class.new(board: x_array) }
      square_array = [red_square, red_square]
      it "replaces it with a red square" do
        expect(update_x.update_markers).to eq(square_array)
      end
    end

    context "when marker is O and location is default" do
      o_array = %w[O O]
      subject(:update_o) { described_class.new(board: o_array) }
      square_array = [blue_square, blue_square]
      it "replaces it with a blue square" do
        expect(update_o.update_markers).to eq(square_array)
      end
    end

    context "when marker is a number and location is default" do
      number_array = %w[1 2]
      subject(:update_numbers) { described_class.new(board: number_array) }
      square_array = [grey_square, grey_square]
      it "replaces it with a grey square" do
        expect(update_numbers.update_markers).to eq(square_array)
      end
    end

    context "when multiple marker types and location is default" do
      subject(:update_full_array) { described_class.new(board: sample_array) }
      it "replaces all markers correctly" do
        expect(update_full_array.update_markers).to eq(home_array)
      end
    end
  end

  describe "#create_visual_board" do
    sample_array = Array.new(42) { |i| (i + 1).to_s }.each_slice(6).to_a
    marker_array = Array.new(42) { "99" }
    visual_string = "          Connect Four           \n\n99 | 99 | 99 | 99 | 99 | 99 | 99\n---+----+----+----+----+----+----\n99 | 99 | 99 | 99 | 99 | 99 | 99\n---+----+----+----+----+----+----\n99 | 99 | 99 | 99 | 99 | 99 | 99\n---+----+----+----+----+----+----\n99 | 99 | 99 | 99 | 99 | 99 | 99\n---+----+----+----+----+----+----\n99 | 99 | 99 | 99 | 99 | 99 | 99\n---+----+----+----+----+----+----\n99 | 99 | 99 | 99 | 99 | 99 | 99\n---+----+----+----+----+----+----\n 1    2    3    4    5    6    7\n"
    context "when given a 2d array of columns" do
      it "converts it to a string version of board" do
        allow(display).to receive(:update_markers).and_return(marker_array)
        expect(display.create_visual_board(sample_array)).to eq(visual_string)
      end
    end
  end
end
