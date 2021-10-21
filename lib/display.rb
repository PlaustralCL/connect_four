#frozen_string_literal: true

# Convert the Board information into something suitable for display.
class Display
  attr_reader :board, :location

  def initialize(board: Array.new(6) { |i| i.to_s }, location: nil)
    @board = board
    @location = location
  end

  def update_markers
    board.flatten.map do |marker|
      case marker
      when "X"
        location ? "\u{1F534}" : "\e[31;41m\u2b1b\e[0m"
      when "O"
        location ? "\u{1f7e1}" : "\e[36;46m\u2b1b\e[0m"
      else
        location ? "\u26ab" : "\e[1;30;1;40m\u2b1b\e[0m"
      end
    end
  end

  def clear_terminal
    system("clear") || system("Cl's")
  end
end