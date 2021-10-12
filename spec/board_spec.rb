# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  subject(:new_board) { described_class.new }
  describe "#initialize" do
    context "when default board is used" do
      it "it creates a hash with 7 keys" do
        key_list = ("1".."7").to_a
        expect(new_board.gameboard.keys).to eq(key_list)
      end

      it "it creates a 6 element array for each key" do
        value_list = ("1".."6").to_a * 7
        expect(new_board.gameboard.values.flatten).to eq(value_list)
      end
    end
  end

  describe "#full_board?" do
    context "when board is not full" do
      it "returns false" do
        expect(new_board.full_board?).to be false
      end
    end

    context "when board is full" do
      it "returns true" do
        col1 = %w[X O X O X O]
        col2 = %w[O X O X O X]
        filled_board = [col1, col2, col1, col1, col2, col2]
        expect(new_board.full_board?(filled_board)).to be true
      end
    end
  end
end