defmodule Part2 do
  def find_stars(input) do
    input
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {c, _} ->
      c == "*"
    end)
    |> Enum.map(fn {_, i} ->
      i
    end)
  end

  def adjacent?(symbol_pos, left, _, width)
      when symbol_pos < left - (width + 1) do
    false
  end

  def adjacent?(symbol_pos, _, right, width)
      when symbol_pos > right + width + 1 do
    false
  end

  def adjacent?(symbol_pos, left, right, width) do
    Enum.any?(
      [-(width + 1), -width, -(width - 1), -1, 1, width - 1, width, width + 1],
      fn position ->
        pos = symbol_pos + position
        pos >= left && pos <= right
      end
    )
  end

  def find_numbers(input) do
    Regex.scan(~r/\d+/, input, return: :index)
    |> List.flatten()
    |> Enum.map(fn {start, length} ->
      match = String.slice(input, start, length)
      {match, start, start + length - 1}
    end)
  end

  def part2(input) do
    [first | _] =
      input
      |> String.split("\n", trim: true)

    width =
      String.length(first)

    input =
      input
      |> String.replace("\n", "")
      |> String.replace(" ", "")

    stars = find_stars(input)
    numbers = find_numbers(input)

    stars
    |> Enum.map(fn star ->
      Enum.filter(numbers, fn number ->
        left = elem(number, 1)
        right = elem(number, 2)
        adjacent?(star, left, right, width)
      end)
    end)
    |> Enum.uniq()
    |> Enum.filter(fn list ->
      length(list) == 2
    end)
    |> Enum.map(fn [{left, _, _}, {right, _, _}] ->
      left = String.to_integer(left)
      right = String.to_integer(right)
      left * right
    end)
    |> Enum.sum()
  end
end

File.read!("input.txt")
|> Part2.part2()
|> IO.inspect(label: "part2")
