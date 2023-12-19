# frozen_string_literal: true

require_relative 'part2'

describe "Part2" do
  describe '#part2' do
    it "verks" do
      input = <<~INPUT
        Time:      7  15   30
        Distance:  9  40  200
      INPUT

      expect(part2(input)).to eq(71_503)
    end
  end
end
