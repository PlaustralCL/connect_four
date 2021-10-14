# frozen_string_literal: true

# Finds the diagonals in a matrix (2d array)
module Diagonal
  def diagonals(matrix)
    matrix = copy_matrix(matrix)
    new_width = new_dimensions(matrix)
    matrix = matrix.map.with_index do |row, index|
      pad_front(row, new_width - index)
      pad_back(row, new_width)
    end
    matrix.transpose.map(&:compact)
  end

  def anti_diagonals(matrix)
    matrix = copy_matrix(matrix)
    new_width = new_dimensions(matrix)
    matrix = matrix.map.with_index do |row, index|
      pad_back(row, new_width - index)
      pad_front(row, new_width)
    end
    matrix.transpose.map(&:compact)
  end

  def copy_matrix(matrix)
    matrix.map { |row| [].replace(row) }
  end

  def new_dimensions(matrix)
    padding = matrix.size - 1
    matrix[0].size + padding
  end

  def pad_front(array, padding)
    array.unshift(nil) while array.size < padding
    array
  end

  def pad_back(array, padding)
    array.push(nil) while array.size < padding
    array
  end
end
