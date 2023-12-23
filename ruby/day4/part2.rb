# frozen_string_literal: true

Game = Struct.new(:wins, :game_count)

def process_line(line)
  line.split(':').last.split('|')
end

def create_games(input)
  input.split("\n")
       .map { |line| process_line(line) }
       .map do |(left, right)|
         Game.new((left.split.map(&:to_i) & right.split.map(&:to_i)).count, 1)
       end
end

def calculate_game_counts(games)
  games.each.with_index do |game, i|
    (i + 1).upto(i + game.wins).reduce(games) do |_, j|
      games[j].game_count += game.game_count if games[j]
      games
    end
  end
end

def part2(input)
  games = create_games(input)
  calculate_game_counts(games)
  games.sum(&:game_count)
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part2(input)
end
