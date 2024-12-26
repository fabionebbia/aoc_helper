defmodule AoC.Input do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(opts) do
    key = {opts[:year], opts[:day]}

    Agent.get_and_update(__MODULE__, fn state ->
      case Map.get(state, key) do
        nil ->
          value = fetch(opts)
          state = Map.put(state, key, value)
          {value, state}

        value ->
          {value, state}
      end
    end)
  end

  defp fetch(opts) do
    session = System.fetch_env!(opts[:session_variable] || "LB_AOC_SESSION")
    year = opts[:year]
    day = opts[:day]

    {:ok, res} =
      Req.get("https://adventofcode.com/#{year}/day/#{day}/input",
        headers: [{"cookie", "session=#{session}"}]
      )

    case res.status do
      200 -> String.trim_trailing(res.body, "\n")
      _ -> raise "\nStatus: #{inspect(res.status)}\nError: #{inspect(String.trim(res.body))}"
    end
  end
end
