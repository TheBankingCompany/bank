defmodule Bank.Ach.FileParser do
  import NimbleParsec

  defmodule Types do
    @spec chars([{:max, pos_integer()} | {:min, non_neg_integer()}] | pos_integer()) ::
            NimbleParsec.t()
    def chars(length) do
      ascii_string([0..127], length)
    end
  end

  defmodule Common do
    import Types

    @spec record_type_code(<<_::8>>) :: NimbleParsec.t()
    def record_type_code(code) when code in ["1", "5", "6", "7", "8", "9"] do
      string(code)
      |> tag(:record_type_code)
    end

    @spec yymmdd() :: NimbleParsec.t()
    def yymmdd() do
      chars(2)
      |> concat(chars(2))
      |> concat(chars(2))
    end

    @spec hhmm() :: NimbleParsec.t()
    def hhmm() do
      chars(2)
      |> concat(chars(2))
    end
  end

  defparsec(:file_header, Bank.Ach.FileParser.FileHeader.record())
  defparsec(:batch_header, Bank.Ach.FileParser.BatchHeader.record())
end
