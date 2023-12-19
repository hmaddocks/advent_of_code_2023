# frozen_string_literal: true

require_relative 'part1'

describe "Part1" do
  describe '#part1' do
    it "verks" do
      input = <<~INPUT
        Time:      7  15   30
        Distance:  9  40  200
      INPUT

      expect(part1(input)).to eq(288)
    end
  end
end
