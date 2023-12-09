# frozen_string_literal: true

require_relative 'part1'

describe "Part1" do
  describe "#find_symbols" do
    it "finds the symbols" do
      input = "467..114.....*........35..633.......#...617*...........+.58...592...........755....$.*.....664.598.."
      expect(find_symbols(input)).to eq([13, 36, 43, 55, 83, 85])
    end
  end

  describe "#find_numbers" do
    it "finds the numbers" do
      input = "467..114.....*........35..633.......#...617*...........+.58...592...........755....$.*.....664.598.."
      expect(find_numbers(input)).to contain_exactly(["467", 0, 2], ["114", 5, 7], ["35", 22, 23], ["633", 26, 28], ["617", 40, 42], ["58", 57, 58], ["592", 62, 64], ["755", 76, 78], ["664", 91, 93], ["598", 95, 97])
    end
  end

  describe "#adjacent?" do
    it "returns true when symbol is adjacent to the number" do
      number = ["633", 26, 28]
      width = 10
      symbol = 36
      expect(adjacent?(symbol, number, width)).to eq(true)
    end

    it "returns false when symbol is not adjacent to the number" do
      number = ["58", 57, 58]
      width = 10
      symbol = 55
      expect(adjacent?(symbol, number, width)).to eq(false)
    end

    it "returns false when symbol is not near to the number" do
      number = ["633", 26, 28]
      width = 10
      symbol = 13
      expect(adjacent?(symbol, number, width)).to eq(false)
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

      expect(part1(input)).to eq(4361)
    end
  end
end
