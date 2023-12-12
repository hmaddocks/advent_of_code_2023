Game = Struct.new(:wins, :count)

def parse(game)
  game.split("|")
end

def part2(input)
  lines = input.split("\n")

  games = lines
          .map { |line| line.split(":").last }
          .map { |game| parse(game) }
          .map { |(left, right)| Game.new(left.split.map(&:to_i).intersection(right.split.map(&:to_i)).count, 1) }

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
