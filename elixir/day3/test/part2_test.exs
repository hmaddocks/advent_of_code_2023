defmodule Part2Test do
  use ExUnit.Case

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

    assert Part2.part2(input) == 467_835
  end
end
