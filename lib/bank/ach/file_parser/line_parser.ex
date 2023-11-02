defmodule Bank.Ach.FileParser.LineParser do
  defmacro __using__([]) do
    quote do
      import unquote(__MODULE__)
      @behaviour unquote(__MODULE__)
    end
  end

  @doc """
  Parses a line.
  """
  @callback parse!(text :: String.t()) :: map
  @callback parse!(text :: String.t(), line_number :: Integer.t()) :: map

  def new!(text, line_number) do
    %{
      text: text,
      line_number: line_number,
      byte_offset: 0,
      record: %{}
    }
  end

  def field!(line, name, length, type) do
    put(line, name, read!(line, length) |> as!(type))
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

  def as!(value, :string) do
    value
  end

  def as!(value, :integer) do
    String.to_integer(value)
  end

  def as!(value, :date) do
    Date.new!(
      2000 + String.to_integer(String.slice(value, 0, 2)),
      String.to_integer(String.slice(value, 2, 2)),
      String.to_integer(String.slice(value, 4, 2))
    )
  end

  def as!(value, :time) do
    Time.new!(
      String.to_integer(String.slice(value, 0, 2)),
      String.to_integer(String.slice(value, 2, 2)),
      0
    )
  end
end
