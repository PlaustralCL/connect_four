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

  def new_board
    ("1".."7").to_a.each_with_object({}) do |key, hash|
      hash[key] = Array.new(6) { |i| (i + 1).to_s }
    end
  end

  def full_board?(columns = gameboard.values)
    columns.flatten.none?(/[1-6]/)
  end

  def column_winner(columns = gameboard.values)
    check_for_winner(columns)
  end

  def row_winner(rows = gameboard.values.transpose)
    check_for_winner(rows)
  end

  def diagonal_winner(matrix = gameboard.values.transpose)
    check_for_winner(diagonals(matrix))
    check_for_winner(anti_diagonals(matrix))
  end

  def check_for_winner(columns = gameboard.values)
    columns.each do |col|
      return @winner = "X" if col.join.include?("XXXX")
      return @winner = "O" if col.join.include?("OOOO")
    end
  end

end
