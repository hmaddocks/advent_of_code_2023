defmodule Part2 do
  def count_wins({time, winning_distance}) do
    x1 = Float.ceil(time / 2.0 - :math.sqrt(Float.pow(time / 2.0, 2) - (winning_distance + 1)))
    x2 = Float.floor(time / 2.0 + :math.sqrt(Float.pow(time / 2.0, 2) - (winning_distance + 1)))

    x2 - x1 + 1
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(":", trim: true)
      |> List.last()
      |> String.split(" ", trim: true)
      |> Enum.join()
      |> String.to_integer()
    end)
    |> List.to_tuple()
    |> count_wins()
  end
end

File.read!(~c"input.txt")
|> Part2.part2()
|> IO.inspect(label: "part2")
