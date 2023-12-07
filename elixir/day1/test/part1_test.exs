defmodule Part1Test do
  use ExUnit.Case

  test "part1" do
    input = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    assert Part1.part1(input) == 142
  end
end
