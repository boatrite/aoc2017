defmodule AdventOfCode2017 do

  def day_1(input) do
    x = String.split(input, "") |>
    Enum.reject(fn(x) -> x == "" end) |>
    Enum.chunk_by(&(&1)) |>
    Enum.filter(fn x -> length(x) > 1 end) |>
    Enum.flat_map(&Enum.drop(&1, 1)) |>
    Enum.map(&String.to_integer(&1)) |>
    Enum.sum

    if String.at(input, 0) == String.at(input, -1) do
      x + String.to_integer(String.at(input, 0))
    else
      x
    end
  end
end
