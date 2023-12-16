use regex::Regex;
use std::collections::HashMap;

fn parse_line(line: &str) -> Vec<HashMap<&str, u32>> {
    line.split(';')
        .map(|game| {
            game.split(',')
                .map(|bag| unwrap_bag(bag))
                .collect::<HashMap<&str, u32>>()
        })
        .collect()
}

fn unwrap_bag(bag: &str) -> (&str, u32) {
    let mut iter = bag.trim().split_whitespace();
    let count = iter.next().unwrap().parse().unwrap();
    let colour = iter.last().unwrap();
    (colour, count)
}

fn parse_game(game: &[HashMap<&str, u32>]) -> u32 {
    let mut max_red = 0;
    let mut max_blue = 0;
    let mut max_green = 0;

    for turn in game {
        if let Some(red) = turn.get("red") {
            max_red = max_red.max(*red);
        }
        if let Some(blue) = turn.get("blue") {
            max_blue = max_blue.max(*blue);
        }
        if let Some(green) = turn.get("green") {
            max_green = max_green.max(*green);
        }
    }

    max_red * max_blue * max_green
}

fn part2(input: &str) -> u32 {
    let mut result = 0;
    for line in input.lines() {
        let re = Regex::new(r"Game \d+: (.*)").unwrap();

        let game = re.captures(line).unwrap()[1].to_string();
        let turns = parse_line(&game);

        result += parse_game(&turns);
    }

    result
}

fn main() {
    let input = include_str!("../../input.txt");
    let output = part2(input);
    dbg!(output);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_line() {
        let line = "3 red, 4 blue; 1 blue, 2 green, 6 red; 2 green";
        let result = parse_line(line);
        let expected = vec![
            [("red", 3), ("blue", 4)].iter().cloned().collect(),
            [("blue", 1), ("green", 2), ("red", 6)]
                .iter()
                .cloned()
                .collect(),
            [("green", 2)].iter().cloned().collect(),
        ];
        assert_eq!(result, expected);
    }

    #[test]
    fn test_parse_game() {
        let game = vec![[("red", 3), ("blue", 4), ("green", 5)]
            .iter()
            .cloned()
            .collect()];
        assert_eq!(parse_game(&game), 60);

        let game = vec![
            [("red", 3), ("blue", 4), ("green", 5)]
                .iter()
                .cloned()
                .collect(),
            [("red", 1), ("blue", 2), ("green", 6)]
                .iter()
                .cloned()
                .collect(),
        ];
        assert_eq!(parse_game(&game), 72);

        let game = vec![
            [("red", 3), ("blue", 4)].iter().cloned().collect(),
            [("green", 6)].iter().cloned().collect(),
        ];
        assert_eq!(parse_game(&game), 72);
    }

    #[test]
    fn test_part1() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";
        assert_eq!(part2(input), 2286);
    }
}
