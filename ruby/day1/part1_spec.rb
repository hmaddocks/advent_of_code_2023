# frozen_string_literal: true

require_relative 'part1'

describe '#part1' do
  it "returns 142 when given the example input" do
    input = <<~INPUT
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    INPUT

    expect(part1(input)).to eq(142)
  end
end
