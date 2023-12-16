fn find_digit(input: &str) -> Vec<u32> {
    input.chars().filter_map(|c| c.to_digit(10)).collect()
}

fn process_line(line: &str) -> u32 {
    let digits = find_digit(line);
    let first = digits.first().unwrap();
    let last = digits.last().unwrap();
    first * 10 + last
}

fn part1(input: &str) -> u32 {
    input.lines().map(process_line).sum()
}

fn main() {
    let input = include_str!("../../input.txt");
    dbg!(part1(input));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_find_digit() {
        assert_eq!(find_digit("abc123"), vec!(1, 2, 3));
        assert_eq!(find_digit("789xyz"), vec!(7, 8, 9));
    }

    #[test]
    fn test_process_line() {
        assert_eq!(process_line("abc123"), 13);
        assert_eq!(process_line("7x8y9xyz"), 79);
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
