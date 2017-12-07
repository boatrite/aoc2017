defmodule Day3Part2Test do
  use ExUnit.Case

  test "solve" do
    assert Day3Part2.solve(1) == 2
    assert Day3Part2.solve(9) == 10
    assert Day3Part2.solve(24) == 25
    assert Day3Part2.solve(30) == 54
    assert Day3Part2.solve(325489) == 330785
  end

  test "spiral" do
    initial = [1, 1, 2, 4, 5, 10, 11, 23, 25, 26, 54, 57, 59, 122, 133, 142, 147, 304, 330, 351, 362]
    assert Day3Part2.spiral |> Enum.take(1) == [1]
    assert Day3Part2.spiral |> Enum.take(2) == [1,1]
    assert Day3Part2.spiral |> Enum.take(10) == [1, 1, 2, 4, 5, 10, 11, 23, 25, 26]
    assert Day3Part2.spiral |> Enum.take(20) == [1, 1, 2, 4, 5, 10, 11, 23, 25, 26,
                                            54, 57, 59, 122, 133, 142, 147,
                                            304, 330, 351]
    assert Day3Part2.spiral |> Enum.take(21) == initial
    assert Day3Part2.spiral |> Enum.take(22) == Enum.concat(initial, [747])
    assert Day3Part2.spiral |> Enum.take(23) == Enum.concat(initial, [747, 806])
    assert Day3Part2.spiral |> Enum.take(100) == [1, 1, 2, 4, 5, 10, 11, 23, 25, 26, 54, 57, 59, 122, 133, 142, 147, 304,
                                             330, 351, 362, 747, 806, 880, 931, 957, 1968, 2105, 2275, 2391, 2450,
                                             5022, 5336, 5733, 6155, 6444, 6591, 13486, 14267, 15252, 16295, 17008,
                                             17370, 35487, 37402, 39835, 42452, 45220, 47108, 48065, 98098, 103128,
                                             109476, 116247, 123363, 128204, 130654, 266330, 279138, 295229, 312453,
                                             330785, 349975, 363010, 369601, 752688, 787032, 830037, 875851, 924406,
                                             975079, 1009457, 1026827, 2089141, 2179400, 2292124, 2411813, 2539320,
                                             2674100, 2814493, 2909666, 2957731, 6013560, 6262851, 6573553, 6902404,
                                             7251490, 7619304, 8001525, 8260383, 8391037, 17048404, 17724526,
                                             18565223, 19452043, 20390510, 21383723, 22427493, 23510079, 24242690]
  end

  test "indices" do
    # Yellows
    # box_number | type_index | index_1 | delta
    # 11         | 0          | 1       | +2
    # 15         | 1          | 3       | +2
    # 19         | 2          | 5       | +3
    # 24         | 3          | 8       | +3
    # 29         | 4          | 11      | +4
    # 35         | 5          | 15      | +4
    # 41         | 6          | 19      | +5
    # 48         | 7          | 24      | +5
    assert Day3Part2.indices(11) == [1, 2, 10]
    assert Day3Part2.indices(15) == [3, 4, 14]
    assert Day3Part2.indices(19) == [5, 6, 18]
    assert Day3Part2.indices(24) == [8, 9, 23]
    assert Day3Part2.indices(29) == [11, 12, 28]
    assert Day3Part2.indices(35) == [15, 16, 34]
    assert Day3Part2.indices(41) == [19, 20, 40]
    assert Day3Part2.indices(48) == [24, 25, 47]

    # Oranges
    # box_number | type_index | index_1 | delta
    # 6          | 0          | 0       | +1
    # 9          | 1          | 1       | +1
    # 12         | 2          | 2       | +2
    # 16         | 3          | 4       | +2
    # 20         | 4          | 6       | +3
    # 25         | 5          | 9       | +3
    # 30         | 6          | 12      | +4
    # 36         | 7          | 16      | +4
    # 42         | 8          | 20      | +5
    # 49         | 9          | 25      | +5
    assert Day3Part2.indices(6) == [0, 5]
    assert Day3Part2.indices(9) == [1, 8]
    assert Day3Part2.indices(12) == [2, 11]
    assert Day3Part2.indices(16) == [4, 15]
    assert Day3Part2.indices(20) == [6, 19]
    assert Day3Part2.indices(25) == [9, 24]
    assert Day3Part2.indices(30) == [12, 29]
    assert Day3Part2.indices(36) == [16, 35]
    assert Day3Part2.indices(42) == [20, 41]

    # Cornerstone greens
    # box_number | type_index | cornerstone_index | delta
    # 21         | 0          | 6                 | +3
    # 26         | 1          | 9                 | +3
    # 31         | 2          | 12                | +4
    # 37         | 3          | 16                | +4
    # 43         | 4          | 20                | +5
    # 50         | 5          | 25                | +5
    assert Day3Part2.indices(21) == [6, 7 , 19, 20]
    assert Day3Part2.indices(26) == [9, 10, 24, 25]
    assert Day3Part2.indices(31) == [12, 13, 29, 30]
    assert Day3Part2.indices(37) == [16, 17, 35, 36]
    assert Day3Part2.indices(43) == [20, 21, 41, 42]

    # Follower greens
    # box_number | type_index | cornerstone_index | delta
    # 22         | 0          | 6                 | +1
    # 23         | 1          | 7                 | +2
    #
    # 27         | 2          | 9                 | +1
    # 28         | 3          | 10                | +2
    #
    # 32         | 4          | 12                | +1
    # 33         | 5          | 13                | +1
    # 34         | 6          | 14                | +2
    #
    # 38         | 7          | 16                | +1
    # 39         | 8          | 17                | +1
    # 40         | 9          | 18                | +2
    #
    # 44         | 10         | 20                | +1
    # 45         | 11         | 21                | +1
    # 46         | 12         | 22                | +1
    # 47         | 13         | 23                | +2
    assert Day3Part2.indices(22) == [6, 7, 8, 21]
    assert Day3Part2.indices(23) == [7, 8, 9, 22]
    assert Day3Part2.indices(27) == [9, 10, 11, 26]
    assert Day3Part2.indices(28) == [10, 11, 12, 27]
    assert Day3Part2.indices(32) == [12, 13, 14, 31]
    assert Day3Part2.indices(33) == [13, 14, 15, 32]
    assert Day3Part2.indices(34) == [14, 15, 16, 33]
    assert Day3Part2.indices(38) == [16, 17, 18, 37]
    assert Day3Part2.indices(39) == [17, 18, 19, 38]
    assert Day3Part2.indices(40) == [18, 19, 20, 39]
    assert Day3Part2.indices(44) == [20, 21, 22, 43]
    assert Day3Part2.indices(45) == [21, 22, 23, 44]
    assert Day3Part2.indices(46) == [22, 23, 24, 45]
    assert Day3Part2.indices(47) == [23, 24, 25, 46]
  end

  test "oranges" do
    assert Day3Part2.oranges |> Enum.take(16) == [
      {6, :o, 0},
      {9, :o, 1},
      {12, :o, 2},
      {16, :o, 3},
      {20, :o, 4},
      {25, :o, 5},
      {30, :o, 6},
      {36, :o, 7},
      {42, :o, 8},
      {49, :o, 9},
      {56, :o, 10},
      {64, :o, 11},
      {72, :o, 12},
      {81, :o, 13},
      {90, :o, 14},
      {100, :o, 15}
    ]
  end

  test "yellows" do
    assert Day3Part2.yellows |> Enum.take(17) == [
      {11, :y, 0},
      {15, :y, 1},
      {19, :y, 2},
      {24, :y, 3},
      {29, :y, 4},
      {35, :y, 5},
      {41, :y, 6},
      {48, :y, 7},
      {55, :y, 8},
      {63, :y, 9},
      {71, :y, 10},
      {80, :y, 11},
      {89, :y, 12},
      {99, :y, 13},
      {109, :y, 14},
      {120, :y, 15},
      {131, :y, 16}
    ]
  end

  #test "greens" do
    #assert Day3Part2.greens |> Enum.take(20) == [
      #{7, :g}, {10, :g}, {13, :g}, {14, :g}, {17, :g},
      #{18, :g}, {21, :g}, {22, :g}, {23, :g}, {26, :g},
      #{27, :g}, {28, :g}, {31, :g}, {32, :g}, {33, :g},
      #{34, :g}, {37, :g}, {38, :g}, {39, :g}, {40, :g}
    #]
  #end

  test "cornerstone_greens" do
    assert Day3Part2.cornerstone_greens |> Enum.take(10) == [
      {21, :cg, 0},
      {26, :cg, 1},
      {31, :cg, 2},
      {37, :cg, 3},
      {43, :cg, 4},
      {50, :cg, 5},
      {57, :cg, 6},
      {65, :cg, 7},
      {73, :cg, 8},
      {82, :cg, 9}
    ]
  end

  test "follower_greens" do
    assert Day3Part2.follower_greens |> Enum.take(14) == [
      {22, :fg, 0},
      {23, :fg, 1},
      {27, :fg, 2},
      {28, :fg, 3},
      {32, :fg, 4},
      {33, :fg, 5},
      {34, :fg, 6},
      {38, :fg, 7},
      {39, :fg, 8},
      {40, :fg, 9},
      {44, :fg, 10},
      {45, :fg, 11},
      {46, :fg, 12},
      {47, :fg, 13}
    ]
  end
end
