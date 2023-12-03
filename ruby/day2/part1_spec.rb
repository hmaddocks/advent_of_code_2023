# frozen_string_literal: true

require_relative 'part1'

describe "Part 1" do
  describe '#part1' do
    let(:bag) do
      {
        red: 12,
        green: 13,
        blue: 14
      }
    end

    it 'returns 0 when there are no games' do
      input = ''
      expect(part1(input)).to eq(0)
    end

    it 'returns the game id when there is one game and it has fewer colors than the bag' do
      input = 'Game 1: 3 blue, 4 red; 1 red, 2 green'
      expect(part1(input)).to eq(1)
    end

    it 'returns 0 when there is one game and it has the same number of colors as the bag' do
      input = 'Game 1: 12 red, 13 green, 14 blue'
      expect(part1(input)).to eq(1)
    end

    it 'returns 0 when there is one game and it has more colors than the bag' do
      input = 'Game 1: 13 red, 4 green, 1 blue'
      expect(part1(input)).to eq(0)
    end

    it 'returns the sum of game ids when there are multiple games and some have fewer colors than the bag' do
      input = <<~INPUT
        Game 1: 3 blue, 4 red; 1 red, 2 green
        Game 2: 12 red, 14 green, 14 blue
        Game 3: 13 red, 14 green, 15 blue
      INPUT
      expect(part1(input)).to eq(1)
    end
  end

  describe '#parse_line' do
    it 'returns an empty array when the line is empty' do
      expect(parse_line('')).to eq([])
    end

    it 'returns the correct data structure when the line has one game' do
      line = '3 blue, 4 red'
      expect(parse_line(line)).to eq([{ blue: 3, red: 4 }])
    end

    it 'returns the correct data structure when the line has two games' do
      line = '3 blue, 4 red; 1 red, 2 green'
      expect(parse_line(line)).to eq([{ blue: 3, red: 4 }, { red: 1, green: 2 }])
    end

    it 'returns the correct data structure when the line has three games' do
      line = '3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'
      expect(parse_line(line)).to eq([{ blue: 3, red: 4 }, { red: 1, green: 2, blue: 6 }, { green: 2 }])
    end
  end

  describe '#parse_game' do
    let(:bag) do
      {
        red: 12,
        green: 13,
        blue: 14
      }
    end

    it 'returns true when there are no turns' do
      game = []
      expect(parse_game(game)).to be_truthy
    end

    it 'returns true when all turns have fewer colors than the bag' do
      game = [{ red: 3, blue: 4 }, { red: 1, green: 2 }]
      expect(parse_game(game)).to be_truthy
    end

    it 'returns true when a turn has the same number of colors as the bag' do
      game = [{ red: 12, green: 13, blue: 14 }]
      expect(parse_game(game)).to be_truthy
    end

    it 'returns false when a turn has more colors than the bag' do
      game = [{ red: 13, green: 13, blue: 14 }]
      expect(parse_game(game)).to be_falsey
    end

    it 'returns false when one of the turns has more colors than the bag' do
      game = [{ red: 3, blue: 4 }, { red: 13, green: 4, blue: 1 }]
      expect(parse_game(game)).to be_falsey
    end
  end
end
