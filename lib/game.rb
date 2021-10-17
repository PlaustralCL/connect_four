# frozen_string_literal: true

# require_relative "board"
# require_relative "player"
# require_relative "display"

# Controls the overall flow of the game by coordinating the actions of the
# board, player, and display.
class Game
  attr_reader :board, :player1, :player2

  def initialize(board = Board.new, player1 = Player.new("Player 1", "X"), player2 = Player.new("Player 2" "O"))
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def play_game
    until board.game_over?
      play_one_round
    end
  end

  def play_one_round

  end
end
