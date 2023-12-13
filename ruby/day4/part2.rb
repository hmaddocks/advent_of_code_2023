# frozen_string_literal: true

Game = Struct.new(:wins, :count)

def part2(input)
  games = input.split("\n")
               .map { |line| line.split(":").last.split("|") }
               .map do |(left, right)|
                 Game.new((left.split.map(&:to_i) & right.split.map(&:to_i)).count, 1)
               end

  games.each.with_index do |game, i|
    (i + 1).upto(i + game.wins) do |j|
      games[j].count += game.count if games[j]
    end
  end

  games.sum(&:count)
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part2(input)
end
