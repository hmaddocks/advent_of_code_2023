fn count_wins(time: f64, distance: f64) -> f64 {
    let x1 = ((time / 2.0) - (((time / 2.0).powf(2f64)) - distance).sqrt()).ceil();
    let x2 = ((time / 2.0) + (((time / 2.0).powf(2f64)) - distance).sqrt()).floor();
    x2 - x1 + 1f64
}

fn transpose(v: Vec<Vec<f64>>) -> Vec<Vec<f64>> {
    assert!(!v.is_empty());
    let len = v[0].len();
    let mut iters: Vec<_> = v.into_iter().map(|n| n.into_iter()).collect();
    (0..len)
        .map(|_| {
            iters
                .iter_mut()
                .map(|n| n.next().unwrap())
                .collect::<Vec<_>>()
        })
        .collect()
}

fn part1(input: &str) -> f64 {
    let lines: Vec<Vec<f64>> = input
        .lines()
        .map(|line| line.trim().split_once(":").unwrap())
        .map(|(_, distance)| fun_name(distance))
        .collect();

    let data = transpose(lines);

    let data = data
        .iter()
        .map(|v| count_wins(v[0], v[1] + 1f64))
        .collect::<Vec<f64>>();

    data.iter().fold(1f64, |acc, f| acc * f)
}

fn fun_name(distance: &str) -> Vec<f64> {
    distance
        .split_whitespace()
        .map(|x| x.parse::<f64>().unwrap())
        .collect()
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
        assert_eq!(part1(input), 288f64);
    }
}
