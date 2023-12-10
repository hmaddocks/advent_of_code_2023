use std::collections::HashSet;

fn part1(input: &str) -> u32 {
    input
        .trim()
        .split("\n")
        .map(|line| line.split(":").collect::<Vec<&str>>()[1])
        .filter_map(|game| {
            let pair: Vec<&str> = game.split("|").collect();

            let first = pair[0].split_whitespace().collect::<Vec<&str>>();
            let second = pair[1].split_whitespace().collect::<Vec<&str>>();

            let l: HashSet<&str> = HashSet::from_iter(first.iter().cloned());
            let r: HashSet<&str> = HashSet::from_iter(second.iter().cloned());
            let i: HashSet<&str> = l.intersection(&r).cloned().collect();
            if i.len() != 0 {
                Some(i.len() as u32)
            } else {
                None
            }
        })
        .map(|c| (2 as u32).pow(c - 1))
        .sum()
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
        let input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11";
        assert_eq!(part1(&input), 13);
    }
}
