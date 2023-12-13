#[derive(Clone)]
struct Game {
    wins: usize,
    count: usize,
}

fn parse_numbers(numbers: &str) -> Vec<u32> {
    numbers
        .split_whitespace()
        .map(|n| n.parse::<u32>().unwrap())
        .collect()
}

fn process_game(line: &str) -> Game {
    let (_game_id, game) = line.split_once(":").unwrap();
    let (winning, mine) = game.split_once("|").unwrap();

    let winning = parse_numbers(winning);
    let mine = parse_numbers(mine);

    let wins = mine.into_iter().filter(|n| winning.contains(n)).count();
    Game { wins, count: 1 }
}

fn part2(input: &str) -> usize {
    let mut games: Vec<Game> = input.lines().map(|line| process_game(line)).collect();

    for i in 0..games.len() {
        let game = games[i].clone();
        for j in i + 1..i + game.wins + 1 {
            if let Some(game_j) = games.get_mut(j) {
                game_j.count += game.count;
            }
        }
    }

    games.iter().map(|game| game.count).sum()
}
fn main() {
    let input = include_str!("../../input.txt");
    dbg!(part2(&input));
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
        assert_eq!(part2(&input), 30);
    }
}
