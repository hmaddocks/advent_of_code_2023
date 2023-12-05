defmodule Part1 do
  def find_digit({head, tail}) do
    case Integer.parse(head) do
      {num, _} -> num
      _ -> find_digit(String.next_grapheme(tail))
    end
  end

  def find_digit(nil) do
    0
  end

  def process_line(line) do
    first =
      line
      |> String.next_grapheme()
      |> find_digit()

    last =
      line
      |> String.reverse()
      |> String.next_grapheme()
      |> find_digit()

    first * 10 + last
  end

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&process_line/1)
    |> Enum.sum()
  end
end

File.read!(~c"input.txt")
|> Part1.part1()
|> IO.inspect(label: "part1")
