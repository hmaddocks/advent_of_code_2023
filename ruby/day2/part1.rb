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
  bag = {
    red: 12,
    green: 13,
    blue: 14
  }

  game.each do |turn|
    reds = turn[:red] || 0
    blues = turn[:blue] || 0
    greens = turn[:green] || 0
    return false if reds > bag[:red] || blues > bag[:blue] || greens > bag[:green]
  end

  true
end

def part1(input)
  input.split("\n").reduce(0) do |result, line|
    game_id, game = line.match(/Game (\d+): (.*)/).captures
    turns = parse_line(game)
    if parse_game(turns)
      result + game_id.to_i
    else
      result
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part1(input)
end
