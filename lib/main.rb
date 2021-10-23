# frozen_string_literal: true

require_relative "board"
require_relative "display"
require_relative "game"
require_relative "player"

# File to initiate the Connect Four game

game = Game.new(display: Display.new(location: ARGV[0]))
game.play_game
