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

  # Brute force solution using Streams. I'm sure there's a constant time
  # mathematical solution, but I can't think of it.
  def day_3_pt_1(input) do
    Stream.iterate(1, &(&1 + 2)) # 1, 3, 5, 7
    |> Stream.map(&(&1 * &1)) # 1, 9, 25, 49
    |> Stream.with_index # {1, 1}, {9, 2}, {25, 3}, {49, 4} The 2nd number is the box number.
    |> Stream.filter(fn {box_max, _} -> input <= box_max end) # This tells us what box we're in.
    |> Stream.map(fn {box_max, box_n} ->
      axis_start = box_max - 7*box_n
      0..3
      |> Enum.map(fn i -> 2*box_n*i + axis_start end)
      |> Enum.map(&(abs(input - &1) + box_n))
      |> Enum.min
    end)
    |> Enum.at(0)
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
