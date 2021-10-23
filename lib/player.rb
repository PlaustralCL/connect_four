# frozen_string_literal: true

require_relative "user_input"

# Holds information about the players. Contain methods for things players do,
# liek select moves
class Player
  include UserInput

  attr_reader :name, :marker

  def initialize(name = "Player", marker = "X")
    @name = name
    @marker = marker
  end

  def player_turn(available_choices)
    loop do
      available_choices << "q" unless available_choices.include?("q")
      input = verify_input(player_input, available_choices)
      return input if input

      puts "Input Error! Please use one of the following choices: #{available_choices.join(', ')}"
    end
  end

  def player_input
    request_input("#{name}, please select a column (1 - 7) that is available, or 'q' to quit")
  end
end
