defmodule Day3Part1Part1Test do
  use ExUnit.Case

  test "day 3 pt 1" do
    # The answer is the sum of the x and y coords of the number
    # Get this and the rest follows
    #assert Day3Part1.day_3_pt_1_helper(1) == {0,0}
    #assert Day3Part1.day_3_pt_1_helper(2) == {0,1}
    #assert Day3Part1.day_3_pt_1_helper(3) == {1,1}
    #assert Day3Part1.day_3_pt_1_helper(4) == {1,0}
    #assert Day3Part1.day_3_pt_1_helper(5) == {-1,1}
    #assert Day3Part1.day_3_pt_1_helper(6) == {-1,0}
    #assert Day3Part1.day_3_pt_1_helper(7) == {-1,-1}
    #assert Day3Part1.day_3_pt_1_helper(8) == {0,-1}
    #assert Day3Part1.day_3_pt_1_helper(9) == {1,-1}
    #assert Day3Part1.day_3_pt_1_helper(10) == {2,-1}
    # I think the number of numbers that fit in each circle is important.
    # That sequence is:
    # n | f(n)
    # 0 | 1 (special case)
    # 1 | 8
    # 2 | 16
    # 3 | 24
    # 4 | 32
    # n | 8*n
    #
    # Maybe something about circles in taxicab geometry. If I can find the circle it lies on,
    # and know the radius of that circle, that radius is the answer.
    #
    # r | straights      | diagonals
    # 1 |  2,  4,  6,  8 |
    # 2 | 11, 15, 19, 23 |  3,  5,  7,  9
    # 3 | 28, 34, 40, 46 | 10, 12, 14, 16, 18, 20, 22, 24
    # 4 | 53, 61, 69, 77 | 13, 17, 21, 25, 27, 29, 33, 35, 39, 41, 45, 47
    # n |
    #
    # 65 64 63 62 61 60 59 58 57
    # 66 37 36 35 34 33 32 31 56
    # 67 38 17 16 15 14 13 30 55
    # 68 39 18  5  4  3 12 29 54
    # 69 40 19  6  █  2 11 28 53
    # 70 41 20  7  8  9 10 27 52
    # 71 42 21 22 23 24 25 26 51
    # 72 43 44 45 46 47 48 49 50
    # 73 74 75 76 77 78 79 80 81
    #
    # The bottom-right diagonal are the squares of 1, 3, 5, 7
    #
    # Given you are in ring X, you are at least X steps away or at most 2*X steps away
    assert Day3Part1.day_3_pt_1(23) == 2
    assert Day3Part1.day_3_pt_1(12) == 3
    assert Day3Part1.day_3_pt_1(14) == 3
    assert Day3Part1.day_3_pt_1(24) == 3
    assert Day3Part1.day_3_pt_1(25) == 4
    assert Day3Part1.day_3_pt_1(77) == 4
    assert Day3Part1.day_3_pt_1(81) == 8
    assert Day3Part1.day_3_pt_1(75) == 6
    assert Day3Part1.day_3_pt_1(1024) == 31
    assert Day3Part1.day_3_pt_1(325489) == 552
  end
end

