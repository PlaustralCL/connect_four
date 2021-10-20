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
    let(:updated_array) {
      [black_circle, black_circle, black_circle, red_circle, yellow_circle, red_circle,
       black_circle, red_circle, red_circle, red_circle, yellow_circle, yellow_circle, yellow_circle]
    }

    context "when marker is X" do
      x_array = %w[X X]
      subject(:update_x) { described_class.new(x_array) }
      circle_array = [red_circle, red_circle]
      it "replaces it with a red circle" do
        expect(update_x.update_markers).to eq(circle_array)
      end
    end

    context "when marker is O" do
      o_array = %w[O O]
      subject(:update_o) { described_class.new(o_array) }
      circle_array = [yellow_circle, yellow_circle]
      it "replaces it with a yellow circle" do
        expect(update_o.update_markers).to eq(circle_array)
      end
    end

    context "when marker is a number" do
      number_array = %w[1 2]
      subject(:update_numbers) { described_class.new(number_array) }
      circle_array = [black_circle, black_circle]
      it "replaces it with a black circle" do
        expect(update_numbers.update_markers).to eq(circle_array)
      end
    end

    context "when multiple marker types" do
      subject(:update_full_array) { described_class.new(sample_array) }
      it "replaces all markers correctly" do
        expect(update_full_array.update_markers).to eq(updated_array)
      end
    end
  end
end
