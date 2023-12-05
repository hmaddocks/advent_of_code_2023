defmodule Part1Test do
  use ExUnit.Case

  test "find_digit/1 returns the first digit in a list" do
    assert Part1.find_digit(String.next_grapheme("123abc")) == 1
    assert Part1.find_digit(String.next_grapheme("abc123")) == 1
    assert Part1.find_digit(String.next_grapheme("abc")) == 0
    assert Part1.find_digit(String.next_grapheme("")) == 0
  end

  test "process_line/1 returns the first and last digit in a line" do
    assert Part1.process_line("123abc") == 13
    assert Part1.process_line("abc123") == 13
    assert Part1.process_line("abc") == 0
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
