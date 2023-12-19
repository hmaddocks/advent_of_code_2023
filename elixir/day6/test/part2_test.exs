defmodule Part2Test do
  use ExUnit.Case

  test "part2" do
    input = """
        Time:      7  15   30
        Distance:  9  40  200
    """

    assert Part2.part2(input) == 71503
  end
end
