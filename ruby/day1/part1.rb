# frozen_string_literal: true

def part1(input)
  input.split("\n")
       .filter_map { |line| line.chars.filter_map { |char| char if char.match?(/\d/) } }
       .sum { |numbers| (numbers.first.to_i * 10) + numbers.last.to_i }
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part1(input)
end
