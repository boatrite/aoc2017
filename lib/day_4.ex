defmodule Day4 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn passphrase -> String.split(passphrase, ~r"\s") end)
    |> Enum.filter(fn words ->
      Enum.uniq(words) == words
    end)
    |> Enum.count
  end

  def solve_pt_2(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn passphrase -> String.split(passphrase, ~r"\s") end)
    |> Enum.filter(fn words ->
      Enum.uniq(words) == words
    end)
    |> Enum.filter(fn words ->
      x = Enum.map(words, fn word -> String.graphemes(word) |> Enum.sort end)
        Enum.uniq(x) == x
    end)
    |> Enum.count
  end
end
