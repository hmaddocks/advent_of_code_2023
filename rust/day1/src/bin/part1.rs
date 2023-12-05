fn find_digit(input: &str) -> Option<u32> {
    input.chars().filter_map(|c| c.to_digit(10)).next()
}

fn process_line(line: &str) -> u32 {
    let first = match find_digit(line) {
        Some(digit) => digit,
        None => 0,
    };
    let reversed_line = line.chars().rev().collect::<String>();
    let last = match find_digit(&reversed_line) {
        Some(digit) => digit,
        None => 0,
    };

    first * 10 + last
}

fn part1(input: &str) -> u32 {
    input.lines().map(process_line).sum()
}

fn main() {
    let input = include_str!("../../input.txt");
    let output = part1(input);
    dbg!(output);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_find_digit() {
        assert_eq!(find_digit("abc123"), Some(1));
        assert_eq!(find_digit("789xyz"), Some(7));
    }

    #[test]
    fn test_process_line() {
        assert_eq!(process_line("abc123"), 13);
        assert_eq!(process_line("xyz789"), 79);
    }

    #[test]
    fn test_part2() {
        let input = "1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet";

        assert_eq!(part1(input), 142);
    }
}
