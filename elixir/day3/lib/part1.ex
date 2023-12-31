defmodule Part1 do
  def find_symbols(input) do
    input
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {c, _} ->
      c != "." &&
        case Integer.parse(c) do
          {_, _} -> false
          _ -> true
        end
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

  def part1(input) do
    [first | _] =
      input
      |> String.split("\n", trim: true)

    width =
      String.length(first)

    input =
      input
      |> String.replace("\n", "")
      |> String.replace(" ", "")

    symbols = find_symbols(input)
    numbers = find_numbers(input)

    symbols
    |> Enum.flat_map(fn symbol ->
      Enum.filter(numbers, fn number ->
        left = elem(number, 1)
        right = elem(number, 2)
        adjacent?(symbol, left, right, width)
      end)
    end)
    |> Enum.uniq()
    |> Enum.map(fn number ->
      case Integer.parse(elem(number, 0)) do
        {n, _} -> n
        _ -> 0
      end
    end)
    |> Enum.sum()
  end
end

File.read!("input.txt")
|> Part1.part1()
|> IO.inspect(label: "part1")
