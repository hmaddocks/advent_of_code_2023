use itertools::Itertools;

fn fun_name3(
    start: usize,
    end: usize,
    mappings: &Vec<(usize, usize, usize)>,
) -> Vec<(usize, usize)> {
    let mut mapped = Vec::new();
    let mut unmapped = vec![(start, end)];

    for &(dst, src, len) in mappings {
        let mut m = Vec::new();
        for (start, end) in unmapped {
            fun_name2(start, end, src, len, &mut m, &mut mapped, dst);
        }
        unmapped = m;
    }

    mapped.extend(unmapped);
    mapped
}

fn fun_name2(
    start: usize,
    end: usize,
    src: usize,
    len: usize,
    m: &mut Vec<(usize, usize)>,
    mapped: &mut Vec<(usize, usize)>,
    dst: usize,
) {
    let a = (start, end.min(src));
    let b = (start.max(src), (src + len).min(end));
    let c = ((src + len).max(start), end);

    if a.0 < a.1 {
        m.push(a);
    }

    if b.0 < b.1 {
        mapped.push((b.0 - src + dst, b.1 - src + dst));
    }

    if c.0 < c.1 {
        m.push(c);
    }
}

fn parse_maps(s: &str) -> Vec<(usize, usize, usize)> {
    s.split('\n')
        .skip(1)
        .map(|l| find_ranges(l))
        .collect::<Vec<_>>()
}

fn find_ranges(l: &str) -> (usize, usize, usize) {
    l.split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect_tuple()
        .unwrap()
}

fn p2(seeds: Vec<usize>, layers: &[Vec<(usize, usize, usize)>]) -> usize {
    let seeds = seeds
        .into_iter()
        .tuples()
        .map(|(a, len)| (a, a + len))
        .collect::<Vec<_>>();

    let locations = layers.iter().fold(seeds, |seeds, mappings| {
        seeds
            .iter()
            .flat_map(|&(start, end)| fun_name3(start, end, mappings))
            .collect()
    });

    locations.iter().map(|r| r.0).min().unwrap()
}

fn part2(input: &str) -> usize {
    let (seeds, rest) = input.split_once("\n\n").unwrap();
    let seeds = seeds
        .split_whitespace()
        .skip(1)
        .map(|s| s.parse().unwrap())
        .collect::<Vec<_>>();

    let layers = rest
        .trim()
        .split("\n\n")
        .map(|s| parse_maps(s))
        .collect::<Vec<_>>();
    p2(seeds, &layers)
}

fn main() {
    let input = include_str!("../../input.txt");
    dbg!(part2(&input));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_find_ranges() {
        assert_eq!(find_ranges("50 98 2"), (50, 98, 2));
        assert_eq!(find_ranges("0 15 37"), (0, 15, 37));
        assert_eq!(find_ranges("88 18 7"), (88, 18, 7));
    }

    #[test]
    fn test_parse_maps() {
        let input = "seed-to-soil map:\n50 98 2\n52 50 48";
        assert_eq!(parse_maps(input), vec![(50, 98, 2), (52, 50, 48)]);
    }

    #[test]
    fn test_fun_name2() {
        let start = 10;
        let end = 20;
        let src = 15;
        let len = 5;
        let dst = 5;

        let mut m = Vec::new();
        let mut mapped = Vec::new();

        fun_name2(start, end, src, len, &mut m, &mut mapped, dst);

        assert_eq!(m, vec![(10, 15), (20, 20)]);
        assert_eq!(mapped, vec![(0, 5)]);
    }

    #[test]
    fn test_fun_name3() {
        let mappings = vec![(50, 98, 2), (52, 50, 48)];
        assert_eq!(fun_name3(50, 100, &mappings), vec![(50, 52), (52, 100)]);
    }
    #[test]
    fn test_p2() {
        let seeds = vec![79, 14, 55, 13];
        let layers = vec![
            vec![(50, 98, 2), (52, 50, 48)],
            vec![(0, 15, 37), (37, 52, 2), (39, 0, 15)],
            vec![(49, 53, 8), (0, 11, 42), (42, 0, 7), (57, 7, 4)],
            vec![(88, 18, 7), (18, 25, 70)],
            vec![(45, 77, 23), (81, 45, 19), (68, 64, 13)],
            vec![(0, 69, 1), (1, 0, 69)],
            vec![(60, 56, 37), (56, 93, 4)],
        ];
        assert_eq!(p2(seeds, &layers), 46);
    }
    #[test]
    fn test_part2() {
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

        assert_eq!(part2(&input), 46);
    }
}
