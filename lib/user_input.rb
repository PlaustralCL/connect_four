# frozen_string_literal: true

# Accept and validate input from the user
module UserInput
  # These methods are tested with the Player class
  def verify_input(input, choices = nil)
    return input if choices.map(&:to_s).include?(input)
  end

  def request_input(phrase)
    puts phrase
    gets.chomp.downcase
  end
end