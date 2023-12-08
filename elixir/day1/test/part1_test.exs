defmodule Part1Test do
  use ExUnit.Case

  test "calculate_sum/1 correctly calculates sum" do
    numbers = ["1", "2", "3"]
    assert Part1.calculate_sum(numbers) == 13
  end

  test "process_line/1 correctly processes lines" do
    line = "123"
    assert Part1.process_line(line) == ["1", "2", "3"]
  end

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
