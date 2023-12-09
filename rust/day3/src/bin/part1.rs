use regex::Regex;

fn find_symbols(input: &str) -> Vec<i32> {
    input
        .chars()
        .enumerate()
        .filter_map(|(i, c)| {
            if c != '.' && !c.is_digit(10) {
                Some(i as i32)
            } else {
                None
            }
        })
        .collect()
}

fn find_numbers(input: &str) -> Vec<(&str, i32, i32)> {
    let re = Regex::new(r"\d+").unwrap();
    re.find_iter(input)
        .map(|m| (m.as_str(), m.start() as i32, (m.end() - 1) as i32))
        .collect()
}

fn adjacent(symbol_pos: i32, number: (&str, i32, i32), width: i32) -> bool {
    if symbol_pos < number.1 - (width + 1) || symbol_pos > number.2 + (width + 1) {
        return false;
    }

    vec![
        -(width + 1),
        -width,
        -(width - 1),
        -1,
        1,
        (width - 1),
        width,
        (width + 1),
    ]
    .iter()
    .any(|pos| {
        let pos = symbol_pos + pos;
        pos >= number.1 && pos <= number.2
    })
}

fn part1(input: &str) -> i32 {
    let width = input.lines().next().unwrap().len() as i32;
    let new_input = input.replace("\n", "");

    let symbols = find_symbols(&new_input);
    let numbers = find_numbers(&new_input);

    symbols
        .iter()
        .flat_map(|symbol| {
            numbers.iter().filter_map(|number| {
                if adjacent(*symbol, *number, width) {
                    let n = number.0.parse::<i32>().unwrap();
                    Some(n)
                } else {
                    None
                }
            })
        })
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
    fn test_find_symbols() {
        let input = "467..114.....*........35..633.......#...617*...........+.58...592...........755....$.*.....664.598..";
        assert_eq!(find_symbols(input), [13, 36, 43, 55, 83, 85]);
    }

    #[test]
    fn test_find_numbers() {
        let input = "467..114.....*........35..633.......#...617*...........+.58...592...........755....$.*.....664.598..";
        assert_eq!(
            find_numbers(input),
            vec![
                ("467", 0, 2),
                ("114", 5, 7),
                ("35", 22, 23),
                ("633", 26, 28),
                ("617", 40, 42),
                ("58", 57, 58),
                ("592", 62, 64),
                ("755", 76, 78),
                ("664", 91, 93),
                ("598", 95, 97)
            ]
        )
    }

    #[test]
    fn test_adjacent_true() {
        let symbol_pos = 36;
        let number = ("123", 26, 28);
        let width = 10;

        assert_eq!(adjacent(symbol_pos, number, width), true);
    }

    #[test]
    fn test_adjacent_false() {
        let symbol_pos = 55;
        let number = ("123", 57, 58);
        let width = 10;

        assert_eq!(adjacent(symbol_pos, number, width), false);
    }

    #[test]
    fn test_adjacent_not_near() {
        let symbol_pos = 13;
        let number = ("123", 26, 28);
        let width = 10;

        assert_eq!(adjacent(symbol_pos, number, width), false);
    }

    #[test]
    fn test_part1() {
        let input = "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..";

        assert_eq!(part1(input), 4361);
    }
}
