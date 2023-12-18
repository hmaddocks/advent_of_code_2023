# frozen_string_literal: true

def parse_line(line)
  line.split(';').map do |game|
    game.split(',').to_h do |bag|
      count, colour = bag.strip.split
      [colour.to_sym, count.to_i]
    end
  end
end

def parse_game(game)
  max_red = 0
  max_blue = 0
  max_green = 0

  game.each do |turn|
    max_red = [turn[:red], max_red].max unless turn[:red].nil?
    max_blue = [turn[:blue], max_blue].max unless turn[:blue].nil?
    max_green = [turn[:green], max_green].max unless turn[:green].nil?
  end

  max_red * max_blue * max_green
end

def part2(input)
  input.split("\n").reduce(0) do |result, line|
    game = line.match(/Game \d+: (.*)/).captures.first
    turns = parse_line(game)
    result + parse_game(turns)
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part2(input)
end
