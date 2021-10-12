# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  describe "#initialize" do
    subject(:new_board) { described_class.new }
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
end