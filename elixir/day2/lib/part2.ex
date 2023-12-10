defmodule Part2 do
  def parse_line(line) do
    line
    |> String.split(";")
    |> Enum.map(fn game ->
      game
      |> String.split(",")
      |> Enum.reduce(%{}, fn bag, acc ->
        [count, colour] = String.split(String.trim(bag))
        Map.put(acc, String.to_atom(colour), String.to_integer(count))
      end)
    end)
  end

  def parse_game(game) do
    {red, green, blue} =
      Enum.reduce(game, {0, 0, 0}, fn turn, {max_red, max_blue, max_green} ->
        reds = turn[:red] || 0
        blues = turn[:blue] || 0
        greens = turn[:green] || 0

        {max(reds, max_red), max(blues, max_blue), max(greens, max_green)}
      end)

    red * green * blue
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      [_, _, game] = Regex.run(~r/Game (\d+): (.*)/, line)
      turns = parse_line(game)
      acc + parse_game(turns)
    end)
  end
end

File.read!("input.txt")
|> Part2.part2()
|> IO.inspect(label: "part2")
