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
    current_player = player1
    until board.game_over?
      break if play_one_round(current_player) == "quit"

      current_player = current_player = player1 ? player2 : player1
    end
    final_message
  end

  def play_one_round(current_player)

  end

  def final_message

  end
end
