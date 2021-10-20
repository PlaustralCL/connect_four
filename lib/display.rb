#frozen_string_literal: true

# Convert the Board information into something suitable for display.
class Display
  attr_reader :board

  def initialize(board = Array.new(6) { |i| i.to_s })
    @board = board
  end

  def update_markers
    board.flatten.map do |marker|
      case marker
      when "X"
        "\u{1F534}"
      when "O"
        "\u{1f7e1}"
      else
        "\u26ab"
      end
    end
  end
end