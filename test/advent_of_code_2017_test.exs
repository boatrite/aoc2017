defmodule AdventOfCode2017Test do
  use ExUnit.Case

  test "day 1" do
    assert AdventOfCode2017.day_1_pt_1("1122") == 3
    assert AdventOfCode2017.day_1_pt_1("1111") == 4
    assert AdventOfCode2017.day_1_pt_1("1234") == 0
    assert AdventOfCode2017.day_1_pt_1("91212129") == 9
  end

  test "day 1 pt 2" do
    assert AdventOfCode2017.day_1_pt_2("1212") == 6
    assert AdventOfCode2017.day_1_pt_2("1221") == 0
    assert AdventOfCode2017.day_1_pt_2("123425") == 4
    assert AdventOfCode2017.day_1_pt_2("123123") == 12
    assert AdventOfCode2017.day_1_pt_2("12131415") == 4
  end
end
