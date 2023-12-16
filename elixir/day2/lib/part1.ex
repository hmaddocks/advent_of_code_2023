defmodule Part1 do
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
    bag = %{
      red: 12,
      green: 13,
      blue: 14
    }

    game
    |> Enum.all?(fn turn ->
      reds = turn[:red] || 0
      blues = turn[:blue] || 0
      greens = turn[:green] || 0

      reds <= bag[:red] && blues <= bag[:blue] && greens <= bag[:green]
    end)
  end

  def parse_game_id(game_id) do
    case Integer.parse(game_id) do
      {i, _} -> i
      _ -> 0
    end
  end

  def process_line(line, acc) do
    [_, game_id, game] = Regex.run(~r/Game (\d+): (.*)/, line)
    turns = parse_line(game)

    if parse_game(turns) do
      acc + parse_game_id(game_id)
    else
      acc
    end
  end

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, &process_line/2)
  end
end

File.read!("input.txt")
|> Part1.part1()
|> IO.inspect(label: "part1")
