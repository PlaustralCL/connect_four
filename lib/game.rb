# frozen_string_literal: true

require_relative "board"
require_relative "player"
require_relative "display"
require_relative "user_input"

# Controls the overall flow of the game by coordinating the actions of the
# board, player, and display.
class Game
  include UserInput

  attr_reader :display, :board, :player1, :player2

  def initialize(
    display: Display.new,
    board: Board.new,
    player1: Player.new("Player 1", "X"),
    player2: Player.new("Player 2", "O")
  )

    @display = display
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def play_game
    setup
    current_player = player1
    until board.game_over?
      break if play_one_round(current_player) == "quit"

      current_player = current_player == player1 ? player2 : player1
    end
    final_message
    reset_game if play_again?
  end

  def play_one_round(current_player)
    column = current_player.player_turn(board.available_columns)
    return "quit" if column == "q"

    board.update_board(column, current_player.marker)
    show_board
  end

  def show_board
    display.clear_terminal
    puts display.create_visual_board(board.gameboard_columns)
  end

  def setup
    introduction
    display.clear_terminal
    show_board
  end

  def final_message
    case board.winner
    when ""
      puts "The game was tied.\nThanks for playing!\n"
    when "X"
      puts "#{player1.name} won!\nThanks for playing!\n"
    else
      puts "#{player2.name} won!\nThanks for playing!\n"
    end
  end

  def play_again?
    phrase = "Do you want to play again? y/N"
    request_input(phrase) == "y"
  end

  def reset_game
    @board = Board.new
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    play_game
  end

  def introduction
    puts "Welcome to Connect Four"
  end
end
