defmodule Part2 do
  def find_numbers_or_digits(line) do
    ~r/\d|(one|two|three|four|five|six|seven|eight|nine)/
    |> Regex.scan(line)
    |> List.flatten()
  end

  def number(word) do
    case word do
      "one" ->
        1

      "two" ->
        2

      "three" ->
        3

      "four" ->
        4

      "five" ->
        5

      "six" ->
        6

      "seven" ->
        7

      "eight" ->
        8

      "nine" ->
        9

      _ ->
        case Integer.parse(word) do
          {num, _} -> num
          _ -> 0
        end
    end
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      numbers =
        line
        |> find_numbers_or_digits()
        |> Enum.map(&number/1)

      acc + Enum.at(numbers, 0) * 10 + Enum.at(numbers, -1)
    end)
  end
end

File.read!("input.txt")
|> Part2.part2()
|> IO.inspect(label: "part2")
