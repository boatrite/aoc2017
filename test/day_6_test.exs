defmodule Day6Test do
  use ExUnit.Case

  test "solve" do
    assert Day6.solve("0 2 7 0") == 5
    assert Day6.solve("11	11	13	7	0	15	5	5	4	4	1	1	7	1	15	11") == 4074
  end

  test "solve_pt_2" do
    assert Day6.solve_pt_2("0 2 7 0") == 4
    assert Day6.solve_pt_2("11	11	13	7	0	15	5	5	4	4	1	1	7	1	15	11") == 2793
  end

  test "do_cycle" do
    assert Day6.do_cycle([0, 2, 7, 0]) == [2, 4, 1, 2]
    assert Day6.do_cycle([2, 4, 1, 2]) == [3, 1, 2, 3]
  end
end
