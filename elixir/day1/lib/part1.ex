defmodule Part1 do
  def filter_digits(char), do: String.match?(char, ~r/\d/)

  def calculate_sum(numbers) do
    String.to_integer(Enum.at(numbers, 0)) * 10 + String.to_integer(Enum.at(numbers, -1))
  end

  def process_line(line) do
    line
    |> String.graphemes()
    |> Enum.filter(&filter_digits/1)
  end

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&process_line/1)
    |> Enum.map(&calculate_sum/1)
    |> Enum.sum()
  end
end

File.read!(~c"input.txt")
|> Part1.part1()
|> IO.inspect(label: "part1")
