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

  def adjacent?(star_pos, number, width) do
    # return false if star_pos < number[1] - (width + 1) || star_pos > (number[2] + width + 1)

    Enum.any?(
      [-(width + 1), -width, -(width - 1), -1, 1, width - 1, width, width + 1],
      fn position ->
        pos = star_pos + position
        pos >= elem(number, 1) && pos <= elem(number, 2)
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
        adjacent?(star, number, width)
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
