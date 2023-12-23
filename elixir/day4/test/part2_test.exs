defmodule Part2Test do
  use ExUnit.Case

  test "build_games_list/1 correctly builds a list of games" do
    line = "Game 1: 3|2"
    expected = %Game{wins: 1, count: 0}

    assert Part2.build_games_list(line) == expected
  end

  test "update_game_count/4 correctly updates the game count" do
    games = [%Game{wins: 2, count: 1}, %Game{wins: 3, count: 2}]
    game = %Game{wins: 2, count: 1}
    expected = [%Game{wins: 2, count: 2}, %Game{wins: 3, count: 2}]

    assert Part2.update_game_count(games, 0, game, Enum.at(games, 0)) == expected
  end

  test "calculate_total_count/1 returns the correct count" do
    games = [
      %Game{wins: 2, count: 1},
      %Game{wins: 3, count: 1},
      %Game{wins: 1, count: 1}
    ]

    assert Part2.calculate_total_count(games) == [
             %Game{wins: 2, count: 1},
             %Game{wins: 3, count: 4},
             %Game{wins: 1, count: 5}
           ]
  end

  test "greets the world" do
    input = """
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    """

    assert Part2.part2(input) == 30
  end
end
