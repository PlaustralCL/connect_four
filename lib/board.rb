# frozen_string_literal: true

# Maintains the overall model of the game. Checks for game over conditions
class Board
  attr_reader :gameboard, :winner

  def initialize(gameboard = nil, winner = nil)
    @gameboard ||= new_board
    @winner = winner
  end

  def new_board
    ("1".."7").to_a.each_with_object({}) do |key, hash|
      hash[key] = Array.new(6) { |i| (i + 1).to_s }
    end
  end
end
