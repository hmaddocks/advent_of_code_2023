defmodule Part2Test do
  use ExUnit.Case

  test "number/1 converts words to numbers" do
    assert Part2.number("one") == 1
    assert Part2.number("two") == 2
    assert Part2.number("three") == 3
    assert Part2.number("four") == 4
    assert Part2.number("five") == 5
    assert Part2.number("six") == 6
    assert Part2.number("seven") == 7
    assert Part2.number("eight") == 8
    assert Part2.number("nine") == 9
  end

  test "number/1 returns the word if it's not a number" do
    assert Part2.number("1") == 1
  end

  test "part2" do
    input = """
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    """

    assert Part2.part2(input) == 281
  end
end
