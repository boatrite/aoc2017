defmodule Day6 do

  def solve(input) do
    bank = String.split(input, ~r"\s")
           |> Enum.map(&String.to_integer/1)
           # feel the jank
    Stream.iterate(2, &(&1 + 1))
    |> Stream.transform({[bank], bank}, &transformer/2)
    |> Enum.to_list
    |> Enum.at(-1)
  end

  def transformer(i, {all_banks, curr_bank}) do
    next_bank = do_cycle(curr_bank)
    if Enum.member?(all_banks, next_bank) do
      { :halt, :whatever }
    else
      next_all_banks = Enum.concat(all_banks, [next_bank])
      { [i], {next_all_banks, next_bank} }
    end
  end

  def solve_pt_2(input) do
    bank = String.split(input, ~r"\s")
           |> Enum.map(&String.to_integer/1)
    x = Stream.iterate(2, &(&1 + 1))
        |> Stream.transform({[bank], bank}, &transformer_pt_2/2)
        |> Enum.to_list
    last = do_cycle Enum.at(x, -1)
    index = Enum.find_index(x, &(&1 == last))
    length(x) - index
  end

  def transformer_pt_2(i, {all_banks, curr_bank}) do
    next_bank = do_cycle(curr_bank)
    if Enum.member?(all_banks, next_bank) do
      { :halt, :whatever }
    else
      next_all_banks = Enum.concat(all_banks, [next_bank])
      { [next_bank], {next_all_banks, next_bank} }
    end
  end

  def do_cycle(bank) do
    b_end = length(bank)
    max = Enum.max(bank)
    index = Enum.find_index(bank, &(&1 == max))
    map = Enum.zip(0..b_end-1, bank) |> Map.new |> Map.put(index, 0)
    Enum.reduce(1..max, map, fn i, map ->
      x = index + i |> Integer.mod(b_end)
      Map.put(map, x, Map.get(map, x)+1)
    end)
    |> Map.values
  end
end
