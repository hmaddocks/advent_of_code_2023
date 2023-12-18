# frozen_string_literal: true

def find_word_or_digit(line)
  numbers = {
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9
  }

  numbers.each do |word, number|
    return number if line.start_with?(word)
  end

  line[0].to_i if line[0].match?(/\d/)
end

def process_line(line)
  first, last = nil
  (0..line.length - 1).each do |index|
    first = find_word_or_digit(line[index..]) if first.nil?
    last = find_word_or_digit(line[index..]) || last
  end

  if first && last
    (first * 10) + last
  else
    0
  end
end

def part2(input)
  input.split("\n").sum { |line| process_line(line) }
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')

  p part2(input)
end
