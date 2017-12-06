defmodule AdventOfCode2017 do

  def day_1_pt_1(input) do
    day_1 input, 1
  end

  def day_1_pt_2(input) do
    step = String.length(input) / 2
    day_1 input, step
  end

  defp day_1(input, step) do
    arr = String.split(input, "") |>
    Enum.reject(fn(el) -> el == "" end)

    Enum.with_index(arr) |>
    Enum.filter(fn({el, index}) -> el == Enum.at(arr, rem(round(index + step), length(arr))) end) |>
    Enum.map(fn {el, _} -> String.to_integer(el) end) |>
    Enum.sum
  end

  def day_2_pt_1(matrix_str) do
    String.split(matrix_str, "\n") |>
    Enum.map(&String.trim(&1)) |>
    Enum.map(&String.split(&1, ~r"\s")) |>
    Enum.map(&Enum.map(&1, fn el -> String.to_integer(el) end)) |>
    Enum.map(&Enum.min_max(&1)) |>
    Enum.map(fn {min, max} -> max - min end) |>
    Enum.sum
  end
end
