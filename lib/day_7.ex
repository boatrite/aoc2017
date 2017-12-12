defmodule Day7 do

  def solve(input) do
    input = String.trim input
    lines = String.split(input, "\n")
    branches = Enum.filter(lines, fn line ->
      Regex.match? ~r"->", line
    end)
    sub_branches = Enum.flat_map(branches, fn line ->
      String.split(line, " -> ") |> Enum.at(1) |> String.split(", ")
    end)
    Enum.reject(branches, fn line ->
      branch_base = String.split(line, ~r"\s") |> Enum.at(0)
      Enum.member? sub_branches, branch_base
    end)
    |> Enum.at(0)
    |> String.split(~r"\s") |> Enum.at(0)
  end
end
