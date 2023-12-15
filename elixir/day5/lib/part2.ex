defmodule Part2 do
  def create_range_map(range_map_list) do
    range_map_list
    |> String.split("\n", trim: true)
    |> Enum.map(fn range_map_string ->
      [dest_start, source_start, range_len] =
        range_map_string
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)

      {Range.new(source_start, source_start + range_len - 1),
       Range.new(dest_start, dest_start + range_len - 1)}
    end)
    |> Enum.into(%{})
  end

  def map_value(range_map, value) do
    looked_up =
      range_map
      |> Enum.find_value(fn {source_range, dest_range} ->
        if value in source_range do
          value_offset = value - source_range.first()
          dest_range.first() + value_offset
        end
      end)

    if is_nil(looked_up), do: value, else: looked_up
  end

  def maps_lookup(range_maps, value) do
    range_maps
    |> Enum.reduce(value, fn range_map, acc ->
      map_value(range_map, acc)
    end)
  end

  def check_in_seed_range(seed_ranges, mapped) do
    Enum.any?(seed_ranges, &in_seed_range?(&1, mapped))
  end

  defp in_seed_range?(seed_range, mapped) do
    mapped in seed_range
  end

  def part2(input) do
    [seeds | maps] =
      input
      |> String.split("\n\n", trim: true)

    seed_ranges =
      seeds
      |> String.split(":", trim: true)
      |> List.last()
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2, 2)
      |> Enum.map(fn [start, length] -> Range.new(start, start + length - 1) end)

    reverse_range_maps =
      maps
      |> Enum.map(fn map_string ->
        map_string
        |> String.split(":", trim: true)
        |> List.last()
        |> String.split("\n", trim: true)
        |> Enum.map(&create_range_map/1)
        |> Enum.reduce(%{}, &Map.merge/2)
        |> Enum.map(fn {source_range, dest_range} ->
          {dest_range, source_range}
        end)
      end)
      |> Enum.reverse()

    first_map = Enum.at(reverse_range_maps, 0)

    max_loc =
      first_map
      |> Enum.map(fn {dest_range, _} -> dest_range.last() end)
      |> Enum.max()

    # chunk to process in 12 parallel tasks
    num_proc = 24
    chunk_size = div(max_loc, num_proc)

    chunk_starts =
      0..num_proc
      |> Enum.map(fn idx -> idx * chunk_size end)

    # Find first location that exists in any seed range
    chunk_starts
    |> Task.async_stream(
      fn chunk_start ->
        chunk_end = chunk_start + chunk_size

        chunk_start..chunk_end
        |> Stream.map(fn loc ->
          mapped = maps_lookup(reverse_range_maps, loc)
          {loc, mapped}
        end)
        |> Stream.filter(fn {loc, mapped} ->
          check_in_seed_range(seed_ranges, mapped)
        end)
        |> Stream.take(1)
        |> Enum.to_list()
        |> List.first()
      end,
      max_concurrency: num_proc,
      timeout: :infinity
    )
    |> Enum.map(&elem(&1, 1))
    |> Enum.filter(&(&1 != nil))
    |> List.first()
    |> elem(0)
  end
end

File.read!("input.txt")
|> Part1.part1()
|> IO.inspect(label: "part1")
