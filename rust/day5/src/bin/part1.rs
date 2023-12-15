use std::{collections::HashMap, ops::Range};

fn create_range_map(range_map_list: &str) -> HashMap<Range<u64>, Range<u64>> {
    let mut range_map = HashMap::new();

    for range_map_str in range_map_list.lines() {
        let parts: Vec<u64> = range_map_str
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        let (dest_start, source_start, range_len) = (parts[0], parts[1], parts[2]);
        range_map.insert(
            source_start..source_start + range_len,
            dest_start..dest_start + range_len,
        );
    }

    range_map
}

fn map_value(range_map: &HashMap<Range<u64>, Range<u64>>, value: u64) -> u64 {
    for (s, d) in range_map {
        if s.contains(&value) {
            let value_offset = value - s.start;
            let looked_up_value = d.start + value_offset;
            return looked_up_value;
        }
    }
    value
}

fn maps_lookup(range_maps: &[HashMap<Range<u64>, Range<u64>>], value: u64) -> u64 {
    range_maps
        .iter()
        .fold(value, |acc, range_map| map_value(range_map, acc))
}

fn part1(input: &str) -> u64 {
    let parts: Vec<&str> = input.split("\n\n").collect();
    let seed_numbers: Vec<u64> = parts[0]
        .split(":")
        .nth(1)
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let range_maps: Vec<HashMap<Range<u64>, Range<u64>>> = parts[1..]
        .iter()
        .map(|&map_string| {
            map_string
                .split(":")
                .nth(1)
                .unwrap()
                .lines()
                .skip(1)
                .map(|map| create_range_map(map))
                .fold(HashMap::new(), |mut acc, map| {
                    acc.extend(map);
                    acc
                })
        })
        .collect();

    let mut seed_to_location_map = HashMap::new();
    for &seed_number in &seed_numbers {
        seed_to_location_map.insert(seed_number, maps_lookup(&range_maps, seed_number));
    }

    *seed_to_location_map.values().min().unwrap()
}

fn main() {
    let input = include_str!("../../input.txt");
    dbg!(part1(&input));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1() {
        let input = "seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69

        humidity-to-location map:
        60 56 37
        56 93 4";
        assert_eq!(part1(&input), 35);
    }
}
