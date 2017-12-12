defmodule Day5 do

  # Keep the initial list always.
  # Also keep track of how many times each number at the index has been incremented.
  # Use the sum to know how many to jump ahead -- less mutation?
  #
  # What if I map the stream to a tuple containing the index to increment and the amount to increment by (pt 1 always 1)
  def solve(initial_jump_list) do
    # Streams probably aren't the best way to do this.
    Stream.iterate(0, &(&1 + 1))
    |> Stream.transform({0, initial_jump_list}, fn _, {instruction, jump_list} ->
      jump_amount = Enum.at(jump_list, instruction)
      if jump_amount do
        next_instruction = instruction + jump_amount
        #next_jump_list = jump_list |> Enum.with_index |> Enum.map(fn {jmp, i} -> if i == instruction, do: jmp + 1, else: jmp end)
        next_jump_list = Enum.concat [Enum.slice(jump_list, 0, instruction), [Enum.at(jump_list, instruction) + 1], Enum.slice(jump_list, (instruction+1)..-1)]
        require IEx; IEx.pry
        next = {next_instruction, next_jump_list}
        {[:ok], next}
      else
        { :halt, :whatever }
      end
    end)
    |> Enum.to_list
    |> length
  end

  def solve_pt_2(initial_jump_list) do
    # Streams probably aren't the best way to do this.
    Stream.iterate(0, &(&1 + 1))
    |> Stream.transform({0, initial_jump_list}, fn _, {instruction, jump_list} ->
      jump_amount = Enum.at(jump_list, instruction)
      if jump_amount do
        next_instruction = instruction + jump_amount
        curr_val = Enum.at(jump_list, instruction)
        next_val = if curr_val >= 3, do: curr_val - 1, else: curr_val + 1
        next_jump_list = Enum.concat [Enum.slice(jump_list, 0, instruction), [next_val], Enum.slice(jump_list, (instruction+1)..-1)]
        next = {next_instruction, next_jump_list}
        {[:ok], next}
      else
        { :halt, :whatever }
      end
    end)
    |> Enum.to_list
    |> length
  end

  def to_s({instruction, jump_list}) do
    jump_list |> Enum.with_index |> Enum.map(fn {jmp, i} ->
      if i == instruction, do: "(#{jmp})", else: " #{jmp} "
    end)
    |> Enum.join(" ")
  end
end
