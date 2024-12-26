defmodule Tmp do
  use AoC,
    year: 2024,
    day: 1

  @impl true
  def parse(input) do
    input
    |> String.split(~r/\s+/, trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple/1)
    |> Enum.unzip()
  end

  @impl true
  def part1({left, right}) do
    left = Enum.sort(left)
    right = Enum.sort(right)

    [left, right]
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  @impl true
  def part2({left, right}) do
    freq = Enum.frequencies(right)

    left
    |> Enum.map(fn id -> id * Map.get(freq, id, 0) end)
    |> Enum.sum()
  end
end
