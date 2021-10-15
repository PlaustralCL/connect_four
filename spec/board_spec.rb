# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  subject(:new_board) { described_class.new }
  col_a = %w[X O X O X O]
  col_b = %w[O X O X O X]
  col_x = %w[X O X X X X]
  col_o = %w[O O O O X O]
  col_xr = %w[O X X X O X]
  col_or = %w[X O O O X O]
  col_empty = Array.new(6) { |i| (i + 1).to_s }

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
      filled_board = { "1" => col_a, "2" => col_b, "3" => col_b, "4" => col_a, "5" => col_a, "6" => col_b, "7" => col_b }
      subject(:board_full) { described_class.new(filled_board) }
      it "returns true" do
        expect(board_full.full_board?).to be true
      end
    end
  end

  describe "#column_winner" do
    context "when 4 connected Xs in a column" do
      col_winning_x_board = { "1" => col_a, "2" => col_b, "3" => col_b, "4" => col_x, "5" => col_a, "6" => col_b, "7" => col_b }
      subject(:column_x) { described_class.new(col_winning_x_board) }
      it "sets @winner to X" do
        column_x.column_winner
        expect(column_x.winner).to eq("X")
      end
    end

    context "when 4 connected Os in a column" do
      it "sets @winner to O" do
        col_winning_o_board = [col_o, col_b, col_b, col_a, col_a, col_b, col_b]
        new_board.column_winner(col_winning_o_board)
        expect(new_board.winner).to eq("O")
      end
    end

    context "when no winning column condition" do
      it "does not change @winner" do
        filled_board = [col_a, col_b, col_b, col_a, col_a, col_b, col_b]
        new_board.column_winner(filled_board)
        expect(new_board.winner).to eq("")
      end
    end
  end

  describe "#row_winner" do
    context "when 4 Xs in a row" do
      it "sets @winner to X" do
        row_winning_x_board = [col_a, col_b, col_xr, col_a, col_a, col_xr, col_b].transpose
        new_board.row_winner(row_winning_x_board)
        expect(new_board.winner).to eq("X")
      end
    end

    context "when 4 connected Os in a row" do
      it "sets @winner to O" do
        row_winning_o_board = [col_or, col_b, col_b, col_or, col_a, col_b, col_b].transpose
        new_board.row_winner(row_winning_o_board)
        expect(new_board.winner).to eq("O")
      end
    end

    context "when no winning row condition" do
      it "returns empty" do
        col_winning_o_board = [col_o, col_b, col_b, col_a, col_a, col_b, col_b].transpose
        new_board.row_winner(col_winning_o_board)
        expect(new_board.winner).to eq("")
      end
    end
  end

  describe "#diagonal_winner" do
    # These tests primarily serve as a test of Diagonal module. It aslo verifies
    # that Board is calling the methods from Diagonal when needed.
    context "when 4 Xs connected in a line" do
      it "sets @winner to X" do
        board = "XOXOXO,OXXOXO,XXXOXO,OXOXOX,XOXOOO,XOXOOX,XOXOXX"
        diag_winning_x_board = board.split(",").map(&:chars).transpose
        new_board.diagonal_winner(diag_winning_x_board)
        expect(new_board.winner).to eq("X")
      end
    end

    context "when 4 Os connected in a diagonal" do
      it "sets @winner to O" do
        board = "OXOXOX,XOOXOX,OOXXOX,XOXOXO,OXXXOX,OXOOXO,OXOXOO"
        diag_winning_o_board = board.split(",").map(&:chars).transpose
        new_board.diagonal_winner(diag_winning_o_board)
        expect(new_board.winner).to eq("O")
      end
    end

    context "when no winning diagonal" do
      it "maintains @winner as empty" do
        col_winning_o_board = [col_o, col_b, col_b, col_a, col_a, col_b, col_b].transpose
        new_board.row_winner(col_winning_o_board)
        expect(new_board.winner).to eq("")
      end
    end
  end

  describe "#game_over?" do
    context "when the board is full" do
      filled_board = { "1" => col_a, "2" => col_b, "3" => col_b, "4" => col_a, "5" => col_a, "6" => col_b, "7" => col_b }
      subject(:game_full) { described_class.new(filled_board) }
      it "returns true" do
        expect(game_full.game_over?).to be true
      end
    end

    context "when board is not full and no winning condition" do
      partial_board = { "1" => col_a, "2" => col_b, "3" => col_empty, "4" => col_empty, "5" => col_empty, "6" => col_empty, "7" => col_b }
      subject(:game_partial) { described_class.new(partial_board) }
      it "returns false" do
        expect(game_partial.game_over?).to be false
      end
    end

    context "when winning on a column" do
      col_winning_o_board = { "1" => col_o, "2" => col_b, "3" => col_b, "4" => col_a, "5" => col_a, "6" => col_b, "7" => col_empty }
      subject(:game_column) { described_class.new(col_winning_o_board) }
      it "returns true" do
        expect(game_column.game_over?).to be true
      end
    end

    context "when winning on a row" do
      row_winning_x_board = { "1" => col_empty, "2" => col_b, "3" => col_xr, "4" => col_a, "5" => col_a, "6" => col_xr, "7" => col_b }
      subject(:game_row) { described_class.new(row_winning_x_board) }
      it "returns true" do
        expect(game_row.game_over?).to be true
      end
    end

    context "when winning on a diagonal" do
      diagonal_winner = { "1" => %w[O X O X O X],
                          "2" => col_empty,
                          "3" => %w[O O X X O X],
                          "4" => %w[X O X O X O],
                          "5" => %w[O X X X O X],
                          "6" => %w[O X O O X O],
                          "7" => %w[O X O X O O] }
      subject(:game_diagonal) { described_class.new(diagonal_winner) }
      it "returns true" do
        expect(game_diagonal.game_over?).to be true
      end
    end
  end
end
