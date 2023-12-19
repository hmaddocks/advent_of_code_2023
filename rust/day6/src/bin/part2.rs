fn count_wins(time: f64, distance: f64) -> f64 {
    let x1 = ((time / 2.0) - (((time / 2.0).powf(2f64)) - distance).sqrt()).ceil();
    let x2 = ((time / 2.0) + (((time / 2.0).powf(2f64)) - distance).sqrt()).floor();
    x2 - x1 + 1f64
}

fn part1(input: &str) -> f64 {
    let lines: Vec<(&str, &str)> = input
        .lines()
        .map(|line| line.trim().split_once(":").unwrap())
        .collect();

    let data: Vec<f64> = lines
        .iter()
        .map(|(_, distance)| fun_name(distance))
        .collect();

    count_wins(data[0], data[1] + 1f64)
}

fn fun_name(distance: &str) -> f64 {
    let s: String = distance.into();
    let distance_str = s.replace(" ", "");
    distance_str.parse().unwrap()
}

fn main() {
    let input = include_str!("../../input.txt");
    dbg!(part1(&input));
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_part1() {
        let input = "Time:      7  15   30
            Distance:  9  40  200";
        assert_eq!(part1(input), 71503f64);
    }
}
