defmodule Day3Part2 do
  def solve(input) do
    spiral() |> Stream.filter(&(input < &1)) |> Enum.at(0)
  end

  def spiral do
    initial = [1, 1, 2, 4, 5, 10, 11, 23, 25, 26, 54, 57, 59, 122, 133, 142,
               147, 304, 330, 351, 362]

    Stream.iterate(0, &add_1/1)
    |> Stream.transform(initial, fn i, curr_spiral ->
      val = Enum.at(curr_spiral, i)
      if val do
        {[val], curr_spiral}
      else
        next_value = Enum.reduce(indices(i), 0, fn box_number, acc ->
          acc + Enum.at(curr_spiral, box_number) end)
        {[next_value], Enum.concat(curr_spiral, [next_value])}
      end
    end)
  end

  def identify(given_box_number) do
    Enum.map([oranges(), yellows(), cornerstone_greens(), follower_greens()], fn stream ->
      Stream.filter(stream, fn {box_number, _, _} ->
        box_number >= given_box_number
      end)
      |> Enum.at(0)
    end)
    |> Enum.filter(fn {box_number, _, _} ->
      box_number == given_box_number
    end)
    |> Enum.at(0)
  end

  def indices({box_number, :o, type_index}) do
    index_deltas = Stream.concat(
      [0],
      Stream.iterate(1, &add_1/1)
      |> Stream.flat_map(&dupe/1)
    )
    first_index = 0
    cornerstone_index_stream = Stream.scan(index_deltas, first_index, &sum/2)
    cornerstone_index = Enum.at(cornerstone_index_stream, type_index)
    [cornerstone_index, box_number - 1]
  end

  def indices({box_number, :y, type_index}) do
    index_deltas = Stream.concat(
      [0],
      Stream.iterate(2, &add_1/1)
      |> Stream.flat_map(&dupe/1)
    )
    first_index = 1
    cornerstone_index_stream = Stream.scan(index_deltas, first_index, &sum/2)
    cornerstone_index = Enum.at(cornerstone_index_stream, type_index)
    [cornerstone_index, cornerstone_index + 1, box_number - 1]
  end

  def indices({box_number, :cg, type_index}) do
    index_deltas = Stream.concat(
      [0],
      Stream.iterate(3, &add_1/1)
      |> Stream.flat_map(&dupe/1)
    )
    first_index = 6
    cornerstone_index_stream = Stream.scan(index_deltas, first_index, &sum/2)
    cornerstone_index = Enum.at(cornerstone_index_stream, type_index)
    [cornerstone_index, cornerstone_index + 1, box_number - 2, box_number - 1]
  end

  def indices({box_number, :fg, type_index}) do
    index_deltas = Stream.concat(
      [0],
      Stream.iterate(1, &add_1/1)
      |> Stream.flat_map(&dupe/1)
      |> Stream.flat_map(fn i ->
        List.duplicate(1, i) |> Stream.concat([2])
      end)
    )
    first_index = 6
    cornerstone_index_stream = Stream.scan(index_deltas, first_index, &sum/2)
    cornerstone_index = Enum.at(cornerstone_index_stream, type_index)
    [cornerstone_index, cornerstone_index + 1, cornerstone_index + 2, box_number - 1]
  end

  def indices(box_number) do
    identify(box_number)
    |> indices
  end

  # Orange indices:
  # 6  , 9  , 12 , 16 , 20 , 25 , 30 , 36 , 42  , ...
  # +3 , +3 , +4 , +4 , +5 , +5 , +6 , +6 , ...
  def oranges do
    deltas = Stream.concat([0], Stream.iterate(3, &add_1/1) |> Stream.flat_map(&dupe/1))
    first_orange_index = 6
    box_numbers = Stream.scan(deltas, first_orange_index, &sum/2)

    type_indices = Stream.iterate(0, &add_1/1)

    [box_numbers, Stream.cycle([:o]), type_indices]
    |> Stream.zip
  end

  # Yellow indices:
  # 11 , 15 , 19 , 24 , 29 , 35 , 41  , ...
  # +4 , +4 , +5 , +5 , +6 , +6 , ...
  def yellows do
    deltas = Stream.concat([0], Stream.iterate(4, &add_1/1) |> Stream.flat_map(&dupe/1))
    first_yellow_index = 11
    box_numbers = Stream.scan(deltas, first_yellow_index, &sum/2)

    type_indices = Stream.iterate(0, &add_1/1)

    [box_numbers, Stream.cycle([:y]), type_indices]
    |> Stream.zip
  end

  def cornerstone_greens do
    deltas = Stream.concat(
      [0],
      Stream.iterate(5, &add_1/1)
      |> Stream.flat_map(&dupe/1)
    )
    first_cornerstone_green_index = 21
    box_numbers = Stream.scan(deltas, first_cornerstone_green_index, &sum/2)

    type_indices = Stream.iterate(0, &add_1/1)

    [box_numbers, Stream.cycle([:cg]), type_indices]
    |> Stream.zip
  end

  # Follower greens
  # 22 , 23 , 27 , 28 , 32 , 33 , 34 , 38 , 39 , 40 , 44 , 45 , 46 , 47
  # +1 , +4 , +1 , +4 , +1 , +1 , +4 , +1 , +1 , +4 , +1 , +1 , +1 , +4
  def follower_greens do
    deltas = Stream.concat(
      [0],
      Stream.iterate(1, &add_1/1)
      |> Stream.flat_map(&dupe/1)
      |> Stream.flat_map(fn i ->
        List.duplicate(1, i) |> Stream.concat([4])
      end)
    )
    first_follower_green_index = 22
    box_numbers = Stream.scan(deltas, first_follower_green_index, &sum/2)

    type_indices = Stream.iterate(0, &add_1/1)

    [box_numbers, Stream.cycle([:fg]), type_indices]
    |> Stream.zip
  end

  def add_1(n) do
    n + 1
  end

  def dupe(x) do
    [x, x]
  end

  def sum(a, b) do
    a + b
  end
end
