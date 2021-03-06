defmodule Day1 do
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
end
