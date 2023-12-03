# frozen_string_literal: true

require_relative 'part2'

describe '#process_line' do
  it 'returns 0 when the line is empty' do
    expect(process_line('')).to eq(0)
  end

  it 'returns 0 when the line has no digits or words representing numbers' do
    expect(process_line('abcdef')).to eq(0)
  end

  it 'returns the correct value when the line has one word representing a number' do
    expect(process_line('one')).to eq(11)
  end

  it 'returns the correct value when the line has one digit' do
    expect(process_line('1')).to eq(11)
  end

  it 'returns the correct value when the line has a word representing a number and a digit' do
    expect(process_line('one2')).to eq(12)
  end

  it 'returns the correct value when the line has a digit and a word representing a number' do
    expect(process_line('1two')).to eq(12)
  end

  it 'returns the correct value when the line has two words representing numbers' do
    expect(process_line('onefour')).to eq(14)
  end

  it 'returns the correct value when the words overlap' do
    expect(process_line('twonefour')).to eq(24)
  end

  it 'returns the correct value when the line has two digits' do
    expect(process_line('12')).to eq(12)
  end
end

describe '#part2' do
  it "return 281 when given the example input" do
    input = <<~INPUT
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    INPUT

    expect(part2(input)).to eq(281)
  end
end

describe '#find_word_or_digit' do
  it 'returns the correct digit when the line starts with a word representing a number' do
    expect(find_word_or_digit('one23')).to eq(1)
  end

  it 'returns the correct digit when the line starts with a digit' do
    expect(find_word_or_digit('123')).to eq(1)
  end

  it 'returns 0 when the line starts with a non-digit, non-word character' do
    expect(find_word_or_digit('abc')).to be_nil
  end
end
