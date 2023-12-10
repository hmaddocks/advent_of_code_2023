use regex::Regex;
use std::collections::HashMap;

fn parse_line(line: &str) -> Vec<HashMap<&str, u32>> {
    line.split(';')
        .map(|game| {
            game.split(',')
                .map(|bag| {
                    let mut iter = bag.trim().split_whitespace();
                    let count = iter.next().unwrap().parse().unwrap();
                    let colour = iter.next().unwrap();
                    (colour, count)
                })
                .collect::<HashMap<_, _>>()
        })
        .collect()
}

fn parse_game(game: &[HashMap<&str, u32>]) -> bool {
    let mut bag = HashMap::new();
    bag.insert("red", 12);
    bag.insert("green", 13);
    bag.insert("blue", 14);

    for turn in game {
        let reds = turn.get("red").unwrap_or(&0);
        let blues = turn.get("blue").unwrap_or(&0);
        let greens = turn.get("green").unwrap_or(&0);
        if *reds > bag["red"] || *blues > bag["blue"] || *greens > bag["green"] {
            return false;
        }
    }

    true
}

fn part1(input: &str) -> u32 {
    let mut result = 0;
    let re = Regex::new(r"Game (\d+): (.*)").unwrap();

    for line in input.lines() {
        if let Some(captures) = re.captures(line) {
            let game_id: u32 = captures[1].parse().unwrap();
            let game = captures[2].to_string();
            let turns = parse_line(&game);

            if parse_game(&turns) {
                result += game_id;
            }
        }
    }

    result
}

fn main() {
    let input = std::fs::read_to_string("input.txt").unwrap();
    let output = part1(&input);
    dbg!(output);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_line() {
        let line = "3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
        let result = parse_line(line);
        let expected = vec![
            [("blue", 3), ("red", 4)].iter().cloned().collect(),
            [("red", 1), ("green", 2), ("blue", 6)]
                .iter()
                .cloned()
                .collect(),
            [("green", 2)].iter().cloned().collect(),
        ];
        assert_eq!(result, expected);
    }

    #[test]
    fn test_parse_game() {
        let game = vec![
            [("blue", 3), ("red", 4)].iter().cloned().collect(),
            [("red", 1), ("green", 2), ("blue", 6)]
                .iter()
                .cloned()
                .collect(),
            [("green", 2)].iter().cloned().collect(),
        ];
        assert_eq!(parse_game(&game), true);

        let game = vec![
            [("blue", 15), ("red", 4)].iter().cloned().collect(),
            [("red", 1), ("green", 2), ("blue", 6)]
                .iter()
                .cloned()
                .collect(),
            [("green", 2)].iter().cloned().collect(),
        ];
        assert_eq!(parse_game(&game), false);
    }

    #[test]
    fn test_part1() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";
        assert_eq!(part1(input), 8);
    }
}
