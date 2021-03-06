defmodule Day3Part2 do
  def solve(input) do
    spiral() |> Stream.filter(&(input < &1)) |> Enum.at(0)
  end

  def spiral do
    initial = [1]
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
    Enum.map([violets(), blues(), oranges(), yellows(), greens(), magentas()], fn stream ->
      Stream.filter(stream, fn {box_number, _, _} ->
        box_number >= given_box_number
      end)
      |> Enum.at(0)
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.filter(fn {box_number, _, _} ->
      box_number == given_box_number
    end)
    |> Enum.at(0)
  end

  def indices({_, :violet, _}) do
    [0]
  end

  def indices({box_number, :blue, _}) do
    [0, box_number - 2, box_number - 1]
  end

  def indices({box_number, :o, type_index}) do
    index_deltas = Stream.concat(
      [0],
      Stream.iterate(0, &add_1/1)
      |> Stream.flat_map(&dupe/1)
    )
    first_index = 0
    cornerstone_index_stream = Stream.scan(index_deltas, first_index, &sum/2)
    cornerstone_index = Enum.at(cornerstone_index_stream, type_index)
    [cornerstone_index, box_number - 1]
  end

  def indices({box_number, :y, type_index}) do
    index_deltas = Stream.concat(
      [0, 1],
      Stream.iterate(2, &add_1/1)
      |> Stream.flat_map(&dupe/1)
    )
    first_index = 0
    cornerstone_index_stream = Stream.scan(index_deltas, first_index, &sum/2)
    cornerstone_index = Enum.at(cornerstone_index_stream, type_index)
    [cornerstone_index, cornerstone_index + 1, box_number - 1]
  end

  def indices({box_number, :green, type_index}) do
    index_deltas = Stream.concat(
      [0],
      Stream.iterate(1, &add_1/1)
      |> Stream.flat_map(&dupe/1)
    )
    first_index = 0
    cornerstone_index_stream = Stream.scan(index_deltas, first_index, &sum/2)
    cornerstone_index = Enum.at(cornerstone_index_stream, type_index)
    [cornerstone_index, cornerstone_index + 1, box_number - 2, box_number - 1]
  end

  def indices({box_number, :magenta, type_index}) do
    index_deltas = Stream.concat(
      [0],
      Stream.iterate(0, &add_1/1)
      |> Stream.flat_map(&dupe/1)
      |> Stream.flat_map(fn i ->
        List.duplicate(1, i) |> Stream.concat([2])
      end)
    )
    first_index = 2
    cornerstone_index_stream = Stream.scan(index_deltas, first_index, &sum/2)
    cornerstone_index = Enum.at(cornerstone_index_stream, type_index)
    [cornerstone_index, cornerstone_index + 1, cornerstone_index + 2, box_number - 1]
  end

  def indices(box_number) do
    identify(box_number)
    |> indices
  end

  def violets do
    [{1, :violet, 0}]
  end

  def blues do
    [{3, :blue, 0}, {5, :blue, 1}]
  end

  def oranges do
    deltas = Stream.concat([0], Stream.iterate(2, &add_1/1) |> Stream.flat_map(&dupe/1))
    first_orange_index = 2
    box_numbers = Stream.scan(deltas, first_orange_index, &sum/2)

    Stream.zip [box_numbers, Stream.cycle([:o]), index()]
  end

  # Yellow indices:
  def yellows do
    deltas = Stream.concat([0, 3], Stream.iterate(4, &add_1/1) |> Stream.flat_map(&dupe/1))
    first_yellow_index = 8
    box_numbers = Stream.scan(deltas, first_yellow_index, &sum/2)

    Stream.zip [box_numbers, Stream.cycle([:y]), index()]
  end

  def greens do
    deltas = Stream.concat(
      [0],
      Stream.iterate(3, &add_1/1)
      |> Stream.flat_map(&dupe/1)
    )
    first_cornerstone_green_index = 7
    box_numbers = Stream.scan(deltas, first_cornerstone_green_index, &sum/2)

    Stream.zip [box_numbers, Stream.cycle([:green]), index()]
  end

  def magentas do
    deltas = Stream.concat(
      [0],
      Stream.iterate(0, &add_1/1)
      |> Stream.flat_map(&dupe/1)
      |> Stream.flat_map(fn i ->
        List.duplicate(1, i) |> Stream.concat([4])
      end)
    )
    first_follower_green_index = 14
    box_numbers = Stream.scan(deltas, first_follower_green_index, &sum/2)

    Stream.zip [box_numbers, Stream.cycle([:magenta]), index()]
  end

  def index do
    Stream.iterate 0, &add_1/1
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
