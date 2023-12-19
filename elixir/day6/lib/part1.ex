defmodule Part1 do
  def count_wins({time, winning_distance}) do
    x1 = Float.ceil(time / 2.0 - :math.sqrt(Float.pow(time / 2.0, 2) - (winning_distance + 1)))
    x2 = Float.floor(time / 2.0 + :math.sqrt(Float.pow(time / 2.0, 2) - (winning_distance + 1)))

    x2 - x1 + 1
  end

  def part1(input) do
    # [times | rest] =
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(":", trim: true)
      |> List.last()
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> List.zip()
    |> Enum.map(&count_wins/1)
    |> Enum.reduce(&Kernel.*/2)
  end
end

File.read!(~c"input.txt")
|> Part1.part1()
|> IO.inspect(label: "part1")
