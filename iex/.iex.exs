import_if_available(Ecto.Query)
import_if_available(Ecto.Changeset)

defmodule Tjak do
  IEx.configure(
    inspect: [limit: 20],
    default_prompt:
      [
        # ANSI CHA, move cursor to column 1
        "\e[G",
        :light_magenta,
        # plain string
        "iex",
        ">",
        :white,
        :reset
      ]
      |> IO.ANSI.format()
      |> IO.chardata_to_string()
  )

  def cmdc(text) when is_binary(text) do
    port = Port.open({:spawn, "pbcopy"}, [])
    true = Port.command(port, text)
    true = Port.close(port)
    :ok
  end

  def cmdc(term, opts \\ []),
    do: inspect(term, Keyword.merge([limit: :infinity, pretty: true], opts)) |> cmdc()

  def cmdv() do
    port = Port.open({:spawn, "pbpaste"}, [])

    receive do
      {^port, {:data, stdout}} -> stdout
    end
  end
end
