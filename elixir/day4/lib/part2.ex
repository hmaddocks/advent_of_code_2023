defmodule Game do
  defstruct wins: 0, count: 1
end

defmodule Part2 do
  def parse_numbers(numbers) do
    String.split(numbers)
    |> Enum.map(&String.to_integer/1)
  end

  def build_games_list(line) do
    [_game_id, game] = String.split(line, ":", parts: 2)
    [winning, mine] = String.split(game, "|") |> Enum.map(&parse_numbers/1)

    wins = Enum.count(mine, &Enum.member?(winning, &1))
    %Game{wins: wins}
  end

  def update_game_count(games, _, _, nil) do
    games
  end

  def update_game_count(games, j, %Game{wins: game_wins, count: game_count}, %Game{
        wins: _,
        count: game_j_count
      }) do
    List.replace_at(games, j, %Game{wins: game_wins, count: game_count + game_j_count})
  end

  def calculate_total_count(games) do
    Enum.with_index(games, fn game, i ->
      Enum.reduce((i + 1)..(i + game.wins), games, fn j, acc ->
        update_game_count(acc, j, game, Enum.at(acc, j))
        |> IO.inspect(label: "games")
      end)
    end)
  end

  def part2(input) do
    games =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&build_games_list/1)

    games = calculate_total_count(games)

    # games
    # |> Enum.map(fn game ->
    #   game.count
    # end)
    # |> Enum.sum()
  end
end

# File.read!("input.txt")
# |> Part2.part2()
# |> IO.inspect(label: "part2")
