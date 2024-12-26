defmodule AoC do
  @callback parse(input :: any()) :: any()
  @callback part1(input :: any()) :: any()
  @callback part2(input :: any()) :: any()

  defmacro __using__(opts) do
    alias AoC.Input

    quote do
      @behaviour AoC

      def solve() do
        %{
          part1: part1(),
          part2: part2()
        }
      end

      def part1() do
        get_input()
        |> parse()
        |> part1()
      end

      def part2() do
        get_input()
        |> parse()
        |> part2()
      end

      defp get_input() do
        Input.get(unquote(opts))
      end
    end
  end
end
