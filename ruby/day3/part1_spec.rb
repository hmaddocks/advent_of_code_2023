# frozen_string_literal: true

require_relative 'part1'

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
