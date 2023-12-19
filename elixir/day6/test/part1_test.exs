defmodule Part1Test do
  use ExUnit.Case

  test "part1" do
    input = """
        Time:      7  15   30
        Distance:  9  40  200
    """

    assert Part1.part1(input) == 288
  end
end
