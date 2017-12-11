defmodule Day5 do

  def solve(initial_jump_list) do
    # Streams probably aren't the best way to do this.
    Stream.iterate(0, &(&1 + 1))
    |> Stream.transform({0, initial_jump_list}, fn _, {instruction, jump_list} ->
      jump_amount = Enum.at(jump_list, instruction)
      if jump_amount do
        next_instruction = instruction + jump_amount
        #next_jump_list = jump_list |> Enum.with_index |> Enum.map(fn {jmp, i} -> if i == instruction, do: jmp + 1, else: jmp end)
        next_jump_list = jump_list |> Enum.with_index |> Enum.map(fn {jmp, i} -> if i == instruction, do: jmp + 1, else: jmp end)
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
        next_jump_list = jump_list |> Enum.with_index |> Enum.map(fn {jmp, i} ->
          if i == instruction do
            if jmp >= 3, do: jmp - 1, else: jmp + 1
          else
            jmp
          end
        end)
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
