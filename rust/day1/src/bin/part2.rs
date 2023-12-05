fn process_line(line: &str) -> u32 {
    let mut first = 0;
    if let Some(digit) = find_first_digit(line) {
        first = digit;
    }

    let mut last = 0;
    if let Some(digit) = find_last_digit(line) {
        last = digit;
    }

    first * 10 + last
}

fn find_first_digit(input: &str) -> Option<u32> {
    let words = [
        "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    ];

    let mut input_index = 0;
    for c in input.chars() {
        for (word_index, word) in words.iter().enumerate() {
            if input[input_index..].starts_with(word) {
                return Some(word_index as u32);
            }
        }

        if let Some(digit) = c.to_digit(10) {
            return Some(digit);
        }

        input_index += 1;
    }

    None
}

fn find_last_digit(input: &str) -> Option<u32> {
    let words = [
        "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    ];

    let mut input_index = 0;
    let mut last = None;
    for c in input.chars() {
        for (word_index, word) in words.iter().enumerate() {
            last = if input[input_index..].starts_with(word) {
                Some(word_index as u32)
            } else {
                last
            };
        }

        if let Some(digit) = c.to_digit(10) {
            last = Some(digit);
        };

        input_index += 1;
    }

    last
}

fn part2(input: &str) -> u32 {
    input.lines().map(process_line).sum()
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
    fn test_find_first_digit() {
        assert_eq!(find_first_digit("abcone23"), Some(1));
        assert_eq!(find_first_digit("abcne23"), Some(2));
        assert_eq!(find_first_digit("xytwonez789"), Some(2));
        assert_eq!(find_first_digit("xytwnez789"), Some(7));

        assert_eq!(find_first_digit("no_digits_here"), None);
    }

    #[test]
    fn test_find_last_digit() {
        assert_eq!(find_last_digit("abconexx"), Some(1));
        assert_eq!(find_last_digit("abcone23"), Some(3));
        assert_eq!(find_last_digit("xytwonez"), Some(1));
        assert_eq!(find_last_digit("xytwonez789"), Some(9));

        assert_eq!(find_last_digit("no_digits_here"), None);
    }

    #[test]
    fn test_part2() {
        let input = "
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen";

        assert_eq!(part2(input), 281);
    }
}
