# frozen_string_literal: true

def part1(input)
  input.split("\n")
       .map { |line| line.split(":").last.split("|") }
       .map { |(winning, mine)| winning.split.map(&:to_i).intersection(mine.split.map(&:to_i)) }
       .reject(&:empty?)
       .sum { |exp| 2**(exp.length - 1) }
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part1(input)
end
