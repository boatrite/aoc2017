defmodule Day3Part1 do
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
