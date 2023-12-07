defmodule Part1 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.filter(fn char ->
        if String.match?(char, ~r/\d/) do
          char
        end
      end)
    end)
    |> Enum.map(fn numbers ->
      String.to_integer(Enum.at(numbers, 0)) * 10 + String.to_integer(Enum.at(numbers, -1))
    end)
    |> Enum.sum()
  end
end

File.read!(~c"input.txt")
|> Part1.part1()
|> IO.inspect(label: "part1")
