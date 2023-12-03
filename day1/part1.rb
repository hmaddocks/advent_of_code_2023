# frozen_string_literal: true

def find_digit(line)
  line.each_char { |char| return char.to_i if char.match?(/\d/) }
  nil
end

def process_line(line)
  first = find_digit(line)
  last = find_digit(line.reverse)

  if first && last
    (first * 10) + last
  else
    0
  end
end

def part1(input)
  input.split("\n").sum { |line| process_line(line) }
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part1(input)
end
