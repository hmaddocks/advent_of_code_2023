# frozen_string_literal: true

def count_wins(time, winning_distance)
  x1 = ((time / 2.0) - Math.sqrt(((time / 2.0)**2) - winning_distance)).ceil
  x2 = ((time / 2.0) + Math.sqrt(((time / 2.0)**2) - winning_distance)).floor

  x2 - x1 + 1
end

def part1(input)
  input.split("\n")
       .map { |l| l.split(":") }
       .map { |l| l.last.split.map(&:to_i) }
       .transpose
       .map { |t, d| count_wins(t, d + 1) }
       .reduce(:*)
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part1(input)
end
