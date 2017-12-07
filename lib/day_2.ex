defmodule Day2 do
  def day_2_pt_1(matrix_str) do
    String.split(matrix_str, "\n") |>
    Enum.map(&String.trim(&1)) |>
    Enum.map(&String.split(&1, ~r"\s")) |>
    Enum.map(&Enum.map(&1, fn el -> String.to_integer(el) end)) |>
    Enum.map(&Enum.min_max(&1)) |>
    Enum.map(fn {min, max} -> max - min end) |>
    Enum.sum
  end

  def day_2_pt_2(input) do
    String.split(input, "\n")
    |> Enum.map(&String.trim(&1))
    |> Enum.map(&String.split(&1, ~r"\s"))
    |> Enum.map(&Enum.map(&1, fn el -> String.to_integer(el) end))
    |> Enum.map(&Combine.combine(&1))
    |> Enum.flat_map(fn row_combinations ->
      Enum.filter(row_combinations, fn pair ->
        rem(Enum.at(pair, 1), Enum.at(pair, 0)) == 0
      end)
    end)
    |> Enum.map(fn pair ->
      Enum.at(pair, 1) / Enum.at(pair, 0)
    end)
    |> Enum.sum
  end
end

defmodule Combine do
  def combine(enumerable) do
    Enum.map(enumerable, fn el ->
      [el, Enum.reject(enumerable, fn el2 -> el == el2 end)]
    end)
    |> Enum.flat_map(fn array ->
      head = Enum.at array, 0
      tail = Enum.at array, 1
      Enum.map(tail, fn el -> [head, el] end)
    end)
    |> Enum.map(&Enum.sort(&1))
    |> Enum.uniq
  end
end
