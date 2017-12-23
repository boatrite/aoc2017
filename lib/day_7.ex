defmodule Day7 do

  def solve(input) do
    lines = get_lines input
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
  end

  def solve_pt_2(input) do
    root_node_value = solve(input)
    lines = get_lines input
    tree = %{value: root_node_value, children: children(lines, root_node_value) }
    IO.puts("\n\n\n*********")
    print(tree, 0)
    IO.puts("*********\n\n\n")
    weight_tree = weight(tree)
    print(weight_tree, 0)
  end

  def get_lines(input) do
    String.split(input, "\n") |> Enum.map(&String.trim/1)
  end

  def children(lines, node_value) do
    chillins = String.split(node_value, " -> ")
               |> Enum.at(1)
    if is_nil chillins do
      []
    else
      x = String.split(chillins, ", ")
      y = Enum.map(x, fn program_name ->
        Enum.find(lines, fn line ->
          String.starts_with? line, program_name
        end)
      end)
      Enum.map(y, fn node_value ->
        %{value: node_value, children: children(lines, node_value)}
        end)
    end
  end

  def weight(tree) do
    line = Map.get(tree, :value)
    w = get_weight(line)
    val = w + (Map.get(tree, :children) |> Enum.map(fn i -> l = Map.get(i, :value); get_weight(l) end) |> Enum.sum)
    %{value: val, children: Map.get(tree, :children) |> Enum.map(fn i -> weight(i) end)}
  end

  def get_weight(line) do
    Regex.run(~r"(\d+)", line) |> Enum.at(0) |> String.to_integer
  end

  def print(tree, indent) do
    spaces = List.duplicate ' ', indent * 2
    str = "#{spaces}#{Map.get(tree, :value)}"
    IO.puts(str)
    unless is_nil Map.get(tree, :children) do
      Enum.each Map.get(tree, :children), &print(&1, indent + 2)
    end
  end

  #def treeify_children(lines, h | []) do
  #%{value: h}
  #end

  #def treeify_children(lines, h | tail) do
  #%{value: h, children: children(lines, )}
  #end

  #def weight(weight_map, program, []) do
  #weight_map[program]
  #end
  #def weight(weight_map, program, array) do
  #weight_map[program] + Enum.sum(array, &weight(weight_map, &1))
  #end
end
