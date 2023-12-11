defmodule Part1 do
  def process_game(line) do
    [_game_id, game] = String.split(line, ":", parts: 2)
    [winning, mine] = String.split(game, "|") |> Enum.map(&parse_numbers/1)
    Enum.filter(mine, &Enum.member?(winning, &1))
  end

  def parse_numbers(numbers) do
    numbers
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&process_game/1)
    |> Enum.filter(&Enum.any?/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.map(fn m ->
      2 ** (m - 1)
    end)
    |> Enum.sum()
  end
end

File.read!("input.txt")
|> Part1.part1()
|> IO.inspect(label: "part1")
