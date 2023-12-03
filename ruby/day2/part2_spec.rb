# frozen_string_literal: true

require_relative 'part2'

describe '#part1' do
  it 'returns the sum of game ids when there are multiple games and some have fewer colors than the bag' do
    input = <<~INPUT
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    INPUT

    expect(part1(input)).to eq(2286)
  end
end

describe '#parse_game' do
  it 'returns 0 when there are no turns' do
    game = []
    expect(parse_game(game)).to eq(0)
  end

  it 'returns the correct product when there is one turn' do
    game = [{red: 3, blue: 4, green: 5}]
    expect(parse_game(game)).to eq(60)
  end

  it 'returns the correct product when there are multiple turns' do
    game = [{red: 3, blue: 4, green: 5}, {red: 1, blue: 2, green: 6}]
    expect(parse_game(game)).to eq(72)
  end

  it 'returns the correct product when there are multiple turns with different colors' do
    game = [{red: 3, blue: 4}, {red: 1, green: 6}]
    expect(parse_game(game)).to eq(72)
  end

  it 'returns the correct product when there are multiple turns with missing colors' do
    game = [{red: 3, blue: 4}, {green: 6}]
    expect(parse_game(game)).to eq(72)
  end
end
