# frozen_string_literal: true

require_relative 'part1'

describe '#process_line' do
  it 'returns 0 when the line is empty' do
    expect(process_line('')).to eq(0)
  end

  it 'returns 0 when the line has no digits' do
    expect(process_line('abcdef')).to eq(0)
  end

  it 'returns the correct value when the line has one digit' do
    expect(process_line('a1b')).to eq(11)
  end

  it 'returns the correct value when the line has two digits' do
    expect(process_line('a1b2c')).to eq(12)
  end

  it 'returns the correct value when the line has more than two digits' do
    expect(process_line('a1b2c3d4')).to eq(14)
  end
end

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
