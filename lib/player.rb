# frozen_string_literal: true

# Holds information about the players. Contain methods for things players do,
# liek select moves
class Player
  attr_reader :name, :marker

  def initialize(name = "Player", marker = "X")
    @name = name
    @marker = marker
  end

  def player_turn(available_choices)
    loop do
      input = verify_input(player_input, available_choices)
      return input if input

      puts "Input Error! Please use one of the following choices: #{available_choices.join(", ")}"
    end
  end

  def verify_input(user_input, choices = nil)
    choices << "q" unless choices.include?("q")
    return user_input if choices.map(&:to_s).include?(user_input)
  end

  def player_input
    puts "#{name}, please select a column (1 - 7) that is available, or 'q' to quit"
    gets.chomp.downcase
  end
end
