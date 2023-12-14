# frozen_string_literal: true

def create_range_map(range_map_list)
  range_map = {}
  range_map_list.split("\n").each do |range_map_string|
    dest_start, source_start, range_len = range_map_string.split.map(&:to_i)
    range_map[(source_start...source_start + range_len)] = (dest_start...dest_start + range_len)
  end
  range_map
end

def map_value(range_map, value)
  looked_up = nil
  range_map.each do |source_range, dest_range|
    next unless source_range.include?(value)

    value_offset = value - source_range.first
    looked_up = dest_range.first + value_offset
    break
  end
  looked_up || value
end

def maps_lookup(range_maps, value)
  range_maps.reduce(value) do |acc, range_map|
    map_value(range_map, acc)
  end
end

def part1(input)
  seeds, *maps = input.split("\n\n")
  seed_numbers = seeds.split(":").last.split.map(&:to_i)

  range_maps = maps.map do |map_string|
    map_string.split(":")
              .last
              .split("\n")
              .map { |map| create_range_map(map) }
              .reduce({}, :merge)
  end

  seed_to_location_map = seed_numbers.each_with_object({}) do |seed_number, hash|
    hash[seed_number] = maps_lookup(range_maps, seed_number)
  end

  seed_to_location_map.min_by { |_, location| location }.last
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part1(input)
end
