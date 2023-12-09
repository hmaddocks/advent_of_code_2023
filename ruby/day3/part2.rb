# frozen_string_literal: true

def find_stars(input)
  [].tap do |symbols|
    input.each_char.with_index do |char, index|
      symbols << index if char == '*'
    end
  end
end

def find_numbers(input)
  str = input
  list = []
  cursor = 0

  loop do
    m = str.match(/\d+/)
    break if m.nil?

    number = m[0]
    offset = m.offset(0)[0] + cursor
    list << [number, offset, offset + number.length - 1]
    str = m.post_match
    cursor += m.offset(0)[1]
  end
  list
end

def adjacent?(symbol_pos, number, width)
  return false if symbol_pos < number[1] - (width + 1) || symbol_pos > (number[2] + width + 1)

  [-(width + 1), -width, -(width - 1), -1, 1, width - 1, width, width + 1].any? do |position|
    pos = symbol_pos + position
    pos >= number[1] && pos <= number[2]
  end
end

def part2(input)
  width = input.split("\n").first.length
  input = input.delete("\n")

  stars = find_stars(input)
  numbers = find_numbers(input)

  stars.map { |star| numbers.select { |number| adjacent?(star, number, width) } }
       .select { |neighbours| neighbours.length == 2 }
       .sum { |(left, right)| left.first.to_i * right.first.to_i }
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part2(input)
end
