# frozen_string_literal: true

require_relative 'part2'

describe "Part2" do
  describe '#find_stars' do
    it "returns an array of indices where '*' is found in the input string" do
      input = <<~INPUT
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
      INPUT

      expect(find_stars(input)).to eq([19, 34, 45])
    end
  end

  describe '#part1' do
    it "verks" do
      input = <<~INPUT
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
      INPUT

      expect(part1(input)).to eq(467_835)
    end
  end
end
