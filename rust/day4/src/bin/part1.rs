fn process_game(line: &str) -> Vec<u32> {
    let (_game_id, game) = line.split_once(":").unwrap();
    let (winning, mine) = game.split_once("|").unwrap();

    let winning = parse_numbers(winning);
    let mine = parse_numbers(mine);

    mine.into_iter()
        .filter(|n| winning.contains(n))
        .collect::<Vec<u32>>()
}

fn parse_numbers(numbers: &str) -> Vec<u32> {
    numbers
        .split_whitespace()
        .map(|n| n.parse::<u32>().unwrap())
        .collect()
}

fn win_count(wins: &Vec<u32>) -> Option<u32> {
    if wins.is_empty() {
        None
    } else {
        Some(wins.len() as u32)
    }
}

fn part1(input: &str) -> u32 {
    input
        .trim()
        .split("\n")
        .map(|line| process_game(line))
        .filter_map(|i| win_count(&i))
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
