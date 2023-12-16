defmodule Part1Test do
  use ExUnit.Case
  doctest Part1

  test "parse_line/1 correctly parses a line" do
    line = "3 red, 2 blue; 1 green, 4 red"

    expected = [
      %{red: 3, blue: 2},
      %{green: 1, red: 4}
    ]

    assert Part1.parse_line(line) == expected
  end

  test "parse_game/1 returns true when all turns are valid" do
    game = [
      %{red: 3, blue: 2},
      %{green: 1, red: 4}
    ]

    assert Part1.parse_game(game) == true
  end

  test "parse_game/1 returns false when a turn is invalid" do
    game = [
      %{red: 3, blue: 2},
      # 14 reds is more than the bag can hold
      %{green: 1, red: 14}
    ]

    assert Part1.parse_game(game) == false
  end

  # test "process_line/2 returns the correct result" do
  #   line = "Game 1: 1, 2, 3, 4, 5"
  #   acc = 0

  #   expected_result = 1
  #   assert Part1.process_line(line, acc) == expected_result
  # end

  test "greets the world" do
    input =
      """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """

    assert Part1.part1(input) == 8
  end
end
