defmodule Bank.Ach.LineParser do
  defmacro __using__([]) do
    quote do
      import unquote(__MODULE__)
      @behaviour unquote(__MODULE__)

      @impl Bank.Ach.LineParser
      def parse!(text) do
        parse!(text, 1, [])
      end

      @impl Bank.Ach.LineParser
      def parse!(text, line_number) when is_integer(line_number) do
        parse!(text, line_number, [])
      end

      @impl Bank.Ach.LineParser
      def parse!(text, opts) when is_list(opts) do
        parse!(text, 1, opts)
      end
    end
  end

  @doc """
  Parses a line.
  """
  @callback parse!(text :: String.t()) :: map
  @callback parse!(text :: String.t(), line_number :: Integer.t()) :: map
  @callback parse!(text :: String.t(), line_number :: Integer.t(), opts :: Keyword.t()) :: map

  def new!(text, line_number, opts \\ []) do
    opts = Keyword.put_new(opts, :cast, true)

    %{
      text: text,
      line_number: line_number,
      byte_offset: 0,
      record: %{},
      opts: opts
    }
  end

  def field!(line, name, requirement, type, length) do
    put(line, name, read!(line, length) |> maybe_cast!(type, requirement, line.opts[:cast]))
    |> advance!(length)
  end

  def put(line, name, value) do
    put_in(line, [:record, name], value)
  end

  def read!(line, length) do
    String.slice(line.text, line.byte_offset, length)
  end

  def advance!(line, length) do
    Map.put(line, :byte_offset, line.byte_offset + length)
  end

  defp maybe_cast!(value, type, requirement, true) do
    cast!(value, type, requirement)
  end

  defp maybe_cast!(value, _type, _requirement, _should_cast) do
    value
  end

  def cast!(value, type, requirement) when requirement in [:O, :ACH] do
    if String.trim(value, " ") == "" do
      nil
    else
      cast!(value, type, :M)
    end
  end

  def cast!(_value, :blank, :NA) do
    nil
  end

  def cast!(value, :routing_number, _requirement) do
    value
  end

  def cast!(value, :padded_routing_number, _requirement) do
    value
  end

  def cast!(value, :upper_az_numeric_09, _requirement) do
    value
  end

  def cast!(value, :alphameric, _requirement) do
    value
  end

  def cast!(value, :amount_in_cents, _requirement) do
    String.to_integer(value)
  end

  def cast!(value, :numeric, _requirement) do
    String.to_integer(value)
  end

  def cast!(value, :yymmdd, _requirement) do
    Date.new!(
      2000 + String.to_integer(String.slice(value, 0, 2)),
      String.to_integer(String.slice(value, 2, 2)),
      String.to_integer(String.slice(value, 4, 2))
    )
  end

  def cast!(value, :mmdd, _requirement) do
    Date.new!(
      0,
      String.to_integer(String.slice(value, 0, 2)),
      String.to_integer(String.slice(value, 2, 2))
    )
  end

  def cast!(value, :mmyy, _requirement) do
    month = String.to_integer(String.slice(value, 0, 2))
    year = 2000 + String.to_integer(String.slice(value, 2, 2))

    Date.new!(
      year,
      month,
      01
    )
  end

  def cast!(value, :hhmm, _requirement) do
    Time.new!(
      String.to_integer(String.slice(value, 0, 2)),
      String.to_integer(String.slice(value, 2, 2)),
      0
    )
  end

  def cast!(value, exact, _requirement) when is_binary(exact) do
    value
  end
end
