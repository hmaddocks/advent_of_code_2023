# frozen_string_literal: true

def process_line(line)
  line.split(':').last.split('|')
end

def calculate_exp(winning, mine)
  winning.split.map(&:to_i) & mine.split.map(&:to_i)
end

def part1(input)
  input.split("\n")
       .map { |line| process_line(line) }
       .map { |(winning, mine)| calculate_exp(winning, mine) }
       .reject(&:empty?)
       .sum { |exp| 2**(exp.length - 1) }
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part1(input)
end
