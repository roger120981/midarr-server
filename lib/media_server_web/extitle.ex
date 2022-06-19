defmodule MediaServer.Extitle do
  def make_cue([_, timing | lines]) do
    [from, to] = timing |> String.split(" --> ")

    [
      %{
        from: from,
        to: to,
        text: lines
      }
    ]
  end

  def parse(path) do
    File.read!(path)
    |> String.split("\n\n", trim: true)
    |> Enum.flat_map(fn item ->
      item
      |> String.split("\n", trim: true)
      |> make_cue
    end)
  end
end
