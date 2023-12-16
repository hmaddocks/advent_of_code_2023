defmodule Part1Test do
  use ExUnit.Case

  test "#find_symbols" do
    input =
      "467..114.....*........35..633.......#...617*...........+.58...592...........755....$.*.....664.598.."

    assert Part1.find_symbols(input) == [13, 36, 43, 55, 83, 85]
  end

  test "find_numbers" do
    input =
      "467..114.....*........35..633.......#...617*...........+.58...592...........755....$.*.....664.598.."

    assert(
      Part1.find_numbers(input) == [
        {"467", 0, 2},
        {"114", 5, 7},
        {"35", 22, 23},
        {"633", 26, 28},
        {"617", 40, 42},
        {"58", 57, 58},
        {"592", 62, 64},
        {"755", 76, 78},
        {"664", 91, 93},
        {"598", 95, 97}
      ]
    )
  end

  test "adjacent returns true when symbol is adjacent to the number" do
    left = 26
    right = 28
    width = 10
    symbol = 36
    assert Part1.adjacent?(symbol, left, right, width) == true
  end

  test "adjacent returns false when symbol is not adjacent to the number" do
    left = 57
    right = 58
    width = 10
    symbol = 55
    assert Part1.adjacent?(symbol, left, right, width) == false
  end

  test "adjacent returns false when symbol is not near to the number" do
    left = 26
    right = 28
    width = 10
    symbol = 13
    assert Part1.adjacent?(symbol, left, right, width) == false
  end

  test "greets the world" do
    input =
      """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """

    assert Part1.part1(input) == 4361
  end
end
