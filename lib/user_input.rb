# frozen_string_literal: true

# Accept and validate input from the user
module UserInput
  # These methods are tested with the Player class
  def verify_input(input, choices = nil)
    return input if choices.map(&:to_s).include?(input)
  end

  def request_input(phrase)
    puts phrase
    # $stdin isnecessary here because ARGV is used in main.rb to
    # initiate the whole program. The gets command looks first to ARGV to
    # receive input so you have to direct it to look at STDIN instead.
    $stdin.gets.chomp.downcase
  end
end
