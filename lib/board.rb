# frozen_string_literal: true

require_relative "diagonal"

# Maintains the overall model of the game. Checks for game over conditions
class Board
  include Diagonal

  attr_reader :gameboard, :winner

  def initialize(gameboard = new_board, winner = "")
    @gameboard = gameboard
    @winner = winner
  end

  def game_over?
    full_board? || winning_position?
  end

  def update_board(column, marker)

  end

  ########################################
  #   Not part of the public interface   #
  ########################################

  def new_board
    ("1".."7").to_a.each_with_object({}) do |key, hash|
      hash[key] = Array.new(6) { |i| (i + 1).to_s }
    end
  end

  def full_board?
    gameboard_columns.flatten.none?(/[1-6]/)
  end

  def winning_position?
    column_winner
    row_winner
    diagonal_winner
    @winner == "X" || @winner == "O"
  end

  def column_winner
    check_for_winner(gameboard_columns)
  end

  def row_winner
    check_for_winner(gameboard_rows)
  end

  def diagonal_winner
    matrix = gameboard_rows
    check_for_winner(diagonals(matrix))
    check_for_winner(anti_diagonals(matrix))
  end

  def check_for_winner(columns = gameboard_columns)
    columns.each do |col|
      return @winner = "X" if col.join.include?("XXXX")
      return @winner = "O" if col.join.include?("OOOO")
    end
  end

  def gameboard_columns
    gameboard.values
  end

  def gameboard_rows
    gameboard.values.transpose
  end

end
