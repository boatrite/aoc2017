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
    assert Day3Part2.spiral |> Enum.take(100) == [1, 1, 2, 4, 5, 10, 11, 23,
                                                  25, 26, 54, 57, 59, 122, 133,
                                                  142, 147, 304, 330, 351, 362,
                                                  747, 806, 880, 931, 957,
                                                  1968, 2105, 2275, 2391, 2450,
                                                  5022, 5336, 5733, 6155, 6444,
                                                  6591, 13486, 14267, 15252,
                                                  16295, 17008, 17370, 35487,
                                                  37402, 39835, 42452, 45220,
                                                  47108, 48065, 98098, 103128,
                                                  109476, 116247, 123363,
                                                  128204, 130654, 266330,
                                                  279138, 295229, 312453,
                                                  330785, 349975, 363010,
                                                  369601, 752688, 787032,
                                                  830037, 875851, 924406,
                                                  975079, 1009457, 1026827,
                                                  2089141, 2179400, 2292124,
                                                  2411813, 2539320, 2674100,
                                                  2814493, 2909666, 2957731,
                                                  6013560, 6262851, 6573553,
                                                  6902404, 7251490, 7619304,
                                                  8001525, 8260383, 8391037,
                                                  17048404, 17724526, 18565223,
                                                  19452043, 20390510, 21383723,
                                                  22427493, 23510079, 24242690]
  end

  test "indices" do
    # Violet
    assert Day3Part2.indices(1) == [0]

    # Blues
    assert Day3Part2.indices(3) == [0, 1, 2]
    assert Day3Part2.indices(5) == [0, 3, 4]

    # Yellows
    # box_number | bn_delta | type_index | cornerstone_index | ci_delta
    #  8         | +3       | 0          | 0                 | +1
    # 11         | +4       | 0          | 1                 | +2
    # 15         | +4       | 1          | 3                 | +2
    # 19         | +5       | 2          | 5                 | +3
    # 24         | +5       | 3          | 8                 | +3
    # 29         | +6       | 4          | 11                | +4
    # 35         | +6       | 5          | 15                | +4
    # 41         | +7       | 6          | 19                | +5
    # 48         | +7       | 7          | 24                | +5
    assert Day3Part2.indices(8) == [0, 1, 7]
    assert Day3Part2.indices(11) == [1, 2, 10]
    assert Day3Part2.indices(15) == [3, 4, 14]
    assert Day3Part2.indices(19) == [5, 6, 18]
    assert Day3Part2.indices(24) == [8, 9, 23]
    assert Day3Part2.indices(29) == [11, 12, 28]
    assert Day3Part2.indices(35) == [15, 16, 34]
    assert Day3Part2.indices(41) == [19, 20, 40]
    assert Day3Part2.indices(48) == [24, 25, 47]

    # Oranges
    # box_number | bn_delta | type_index | cornerstone_index | ci_delta
    # 2          | +2       | 0          | 0                 | +0
    # 4          | +2       | 1          | 0                 | +0
    # 6          | +3       | 2          | 0                 | +1
    # 9          | +3       | 3          | 1                 | +1
    # 12         | +4       | 4          | 2                 | +2
    # 16         | +4       | 5          | 4                 | +2
    # 20         | +5       | 6          | 6                 | +3
    # 25         | +5       | 7          | 9                 | +3
    # 30         | +6       | 8          | 12                | +4
    # 36         | +6       | 9          | 16                | +4
    # 42         | +7       | 10         | 20                | +5
    # 49         | +7       | 11         | 25                | +5
    assert Day3Part2.indices(2) == [0, 1]
    assert Day3Part2.indices(4) == [0, 3]
    assert Day3Part2.indices(6) == [0, 5]
    assert Day3Part2.indices(9) == [1, 8]
    assert Day3Part2.indices(12) == [2, 11]
    assert Day3Part2.indices(16) == [4, 15]
    assert Day3Part2.indices(20) == [6, 19]
    assert Day3Part2.indices(25) == [9, 24]
    assert Day3Part2.indices(30) == [12, 29]
    assert Day3Part2.indices(36) == [16, 35]
    assert Day3Part2.indices(42) == [20, 41]

    # Greens
    # box_number | bn_delta | type_index | cornerstone_index | ci_delta
    #  7         | +3       | 0          | 0                 | +1
    # 10         | +3       | 1          | 1                 | +1
    # 13         | +4       | 2          | 2                 | +2
    # 17         | +4       | 3          | 4                 | +2
    # 21         | +5       | 4          | 6                 | +3
    # 26         | +5       | 5          | 9                 | +3
    # 31         | +6       | 6          | 12                | +4
    # 37         | +6       | 7          | 16                | +4
    # 43         | +7       | 8          | 20                | +5
    # 50         | +7       | 9          | 25                | +5
    assert Day3Part2.indices(7) == [0, 1, 5, 6]
    assert Day3Part2.indices(10) == [1, 2, 8, 9]
    assert Day3Part2.indices(13) == [2, 3, 11, 12]
    assert Day3Part2.indices(17) == [4, 5, 15, 16]
    assert Day3Part2.indices(21) == [6, 7 , 19, 20]
    assert Day3Part2.indices(26) == [9, 10, 24, 25]
    assert Day3Part2.indices(31) == [12, 13, 29, 30]
    assert Day3Part2.indices(37) == [16, 17, 35, 36]
    assert Day3Part2.indices(43) == [20, 21, 41, 42]

    # Magentas
    # box_number | bn_delta | type_index | cornerstone_index | ci_delta
    # 14         | +4       | 0          | 2                 | +2
    # 18         | +4       | 1          | 4                 | +2
    # 22         | +1       | 2          | 6                 | +1
    # 23         | +4       | 3          | 7                 | +2
    # 27         | +1       | 4          | 9                 | +1
    # 28         | +4       | 5          | 10                | +2
    # 32         | +1       | 6          | 12                | +1
    # 33         | +1       | 7          | 13                | +1
    # 34         | +4       | 8          | 14                | +2
    # 38         | +1       | 9          | 16                | +1
    # 39         | +1       | 10         | 17                | +1
    # 40         | +4       | 11         | 18                | +2
    # 44         | +1       | 12         | 20                | +1
    # 45         | +1       | 13         | 21                | +1
    # 46         | +1       | 14         | 22                | +1
    # 47         | +4       | 15         | 23                | +2
    assert Day3Part2.indices(14) == [2, 3, 4, 13]
    assert Day3Part2.indices(18) == [4, 5, 6, 17]
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
    assert Day3Part2.oranges |> Enum.take(18) == [
      {2, :o, 0},
      {4, :o, 1},
      {6, :o, 2},
      {9, :o, 3},
      {12, :o, 4},
      {16, :o, 5},
      {20, :o, 6},
      {25, :o, 7},
      {30, :o, 8},
      {36, :o, 9},
      {42, :o, 10},
      {49, :o, 11},
      {56, :o, 12},
      {64, :o, 13},
      {72, :o, 14},
      {81, :o, 15},
      {90, :o, 16},
      {100, :o, 17}
    ]
  end

  test "yellows" do
    assert Day3Part2.yellows |> Enum.take(18) == [
      {8, :y, 0},
      {11, :y, 1},
      {15, :y, 2},
      {19, :y, 3},
      {24, :y, 4},
      {29, :y, 5},
      {35, :y, 6},
      {41, :y, 7},
      {48, :y, 8},
      {55, :y, 9},
      {63, :y, 10},
      {71, :y, 11},
      {80, :y, 12},
      {89, :y, 13},
      {99, :y, 14},
      {109, :y, 15},
      {120, :y, 16},
      {131, :y, 17}
    ]
  end

  test "greens" do
    assert Day3Part2.greens |> Enum.take(14) == [
      {7, :green, 0},
      {10, :green, 1},
      {13, :green, 2},
      {17, :green, 3},
      {21, :green, 4},
      {26, :green, 5},
      {31, :green, 6},
      {37, :green, 7},
      {43, :green, 8},
      {50, :green, 9},
      {57, :green, 10},
      {65, :green, 11},
      {73, :green, 12},
      {82, :green, 13}
    ]
  end

  test "magentas" do
    assert Day3Part2.magentas |> Enum.take(16) == [
      {14, :magenta, 0},
      {18, :magenta, 1},
      {22, :magenta, 2},
      {23, :magenta, 3},
      {27, :magenta, 4},
      {28, :magenta, 5},
      {32, :magenta, 6},
      {33, :magenta, 7},
      {34, :magenta, 8},
      {38, :magenta, 9},
      {39, :magenta, 10},
      {40, :magenta, 11},
      {44, :magenta, 12},
      {45, :magenta, 13},
      {46, :magenta, 14},
      {47, :magenta, 15}
    ]
  end
end
