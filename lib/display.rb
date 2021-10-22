# frozen_string_literal: true

# Convert the Board information into something suitable for display.
class Display
  BLACK_CIRCLE = "\u26ab"
  RED_CIRCLE = "\u{1F534}"
  YELLOW_CIRCLE = "\u{1f7e1}"
  RED_SQUARE = "\e[31;41m\u2b1b\e[0m"
  BLUE_SQUARE = "\e[36;46m\u2b1b\e[0m"
  GREY_SQUARE = "\e[1;30;1;40m\u2b1b\e[0m"

  attr_reader :board, :location

  def initialize(board: [], location: nil)
    @board = board
    @location = location
  end

  def create_visual_board(board_columns = [])
    @board = board_columns
    @board = update_markers.each_slice(6).to_a
    "#{'Connect Four'.center(33)}\n\n#{visual_board}#{column_names}\n"
  end

  # This method currently returns a one dimensional array
  def update_markers
    board.flatten.map do |marker|
      case marker
      when "X"
        location ? RED_CIRCLE : RED_SQUARE
      when "O"
        location ? YELLOW_CIRCLE : BLUE_SQUARE
      else
        location ? BLACK_CIRCLE : GREY_SQUARE
      end
    end
  end

  # Takes a 2d array, where each subarray represents a column of the board and
  # returns a string
  def visual_board
    board.transpose
         .map { |row| row.join(" | ") }
         .map { |row| row + "\n---+----+----+----+----+----+----\n" }
         .join
  end

  def column_names
    Array.new(7) { |i| i.zero? ? (i + 1).to_s.rjust(2) : (i + 1).to_s.rjust(5) }.join
  end

  def clear_terminal
    system("clear") || system("Cl's")
  end
end
