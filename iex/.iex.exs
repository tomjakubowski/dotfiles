import_if_available(Ecto.Query)
import_if_available(Ecto.Changeset)

defmodule TJ do
  IEx.configure(
    inspect: [limit: 20]
    # default_prompt:
    #   [
    #     # ANSI CHA, move cursor to column 1
    #     "\e[G",
    #     :light_magenta,
    #     # plain string
    #     "iex",
    #     ">",
    #     :white,
    #     :reset
    #   ]
    #   |> IO.ANSI.format()
    #   |> IO.chardata_to_string()
  )

  @doc "Copy text to clipboard"
  def copy(text) when is_binary(text) do
    port = Port.open({:spawn, "pbcopy"}, [])
    true = Port.command(port, text)
    true = Port.close(port)
    :ok
  end

  @doc "Copy inspect(term) to clipboard"
  def copy(term, opts \\ []),
    do: inspect(term, Keyword.merge([limit: :infinity, pretty: true], opts)) |> copy()

  @doc "Paste from clipboard"
  def paste() do
    port = Port.open({:spawn, "pbpaste"}, [])

    receive do
      {^port, {:data, stdout}} -> stdout
    end
  end
end
