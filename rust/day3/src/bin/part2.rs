use regex::Regex;

fn find_stars(input: &str) -> Vec<i32> {
    input
        .chars()
        .enumerate()
        .filter_map(|(i, c)| if c == '*' { Some(i as i32) } else { None })
        .collect()
}

fn find_numbers(input: &str) -> Vec<(&str, i32, i32)> {
    let re = Regex::new(r"\d+").unwrap();
    re.find_iter(input)
        .map(|m| (m.as_str(), m.start() as i32, (m.end() - 1) as i32))
        .collect()
}

fn adjacent(symbol_pos: i32, number: &(&str, i32, i32), width: i32) -> bool {
    if symbol_pos < number.1 - (width + 1) || symbol_pos > number.2 + (width + 1) {
        return false;
    }

    let positions: Vec<i32> = vec![
        -(width + 1),
        -width,
        -(width - 1),
        -1,
        1,
        (width - 1),
        width,
        (width + 1),
    ];

    positions.iter().any(|pos| {
        let pos = symbol_pos + pos;
        pos >= number.1 && pos <= number.2
    })
}

fn part2(input: &str) -> i32 {
    let width = input.lines().next().unwrap().len() as i32;
    let new_input = input.replace("\n", "");

    let stars = find_stars(&new_input);
    let numbers = find_numbers(&new_input);

    let neighbours: Vec<Vec<(&str, i32, i32)>> = stars
        .iter()
        .map(|star| {
            numbers
                .iter()
                .filter(|number| adjacent(*star, *number, width))
                .cloned() // Clone the elements before collecting them
                .collect()
        })
        .collect();

    neighbours
        .iter()
        .filter(|n| n.len() == 2)
        .map(|pair| {
            let left = pair[0].0.parse::<i32>().unwrap();
            let right = pair[1].0.parse::<i32>().unwrap();
            left * right
        })
        .sum()
}

fn main() {
    let input = include_str!("../../input.txt");
    dbg!(part2(&input));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_find_stars() {
        let input = "467..114.....*........35..633.......#...617*...........+.58...592...........755....$.*.....664.598..";
        assert_eq!(find_stars(input), [13, 43, 85]);
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

        assert_eq!(adjacent(symbol_pos, &number, width), true);
    }

    #[test]
    fn test_adjacent_false() {
        let symbol_pos = 55;
        let number = ("123", 57, 58);
        let width = 10;

        assert_eq!(adjacent(symbol_pos, &number, width), false);
    }

    #[test]
    fn test_adjacent_not_near() {
        let symbol_pos = 13;
        let number = ("123", 26, 28);
        let width = 10;

        assert_eq!(adjacent(symbol_pos, &number, width), false);
    }

    #[test]
    fn test_part2() {
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

        assert_eq!(part2(input), 467_835);
    }
}
