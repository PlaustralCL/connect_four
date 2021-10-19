# frozen_string_literal: true

# require_relative "board"
# require_relative "player"
# require_relative "display"
require_relative "user_input"

# Controls the overall flow of the game by coordinating the actions of the
# board, player, and display.
class Game
  include UserInput

  attr_reader :board, :player1, :player2

  def initialize(board = Board.new, player1 = Player.new("Player 1", "X"), player2 = Player.new("Player 2" "O"))
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def play_game
    setup
    current_player = player1
    until board.game_over?
      break if play_one_round(current_player) == "quit"

      current_player = current_player = player1 ? player2 : player1
    end
    final_message
    reset_game if play_again?
  end

  def play_one_round(current_player)
    column = current_player.player_turn
    return "quit" if column == "q"

    board.update_board(column, current_player.marker)
    show_board
  end

  def show_board

  end

  def setup
    introduction
    show_board
  end

  def final_message
    if board.winner == ""
      puts "The game was tied.\nThanks for playing!\n"
    elsif board.winner == "X"
      puts "#{player1.name} won!\nThanks for playing!\n"
    else
      puts "#{player2.name} won!\nThanks for playing!\n"
    end
  end

  def play_again?
    request_input("Do you want to play again? Y/n")
  end

  def reset_game
    @board = Board.new
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    play_game
  end

  def introduction

  end

end
