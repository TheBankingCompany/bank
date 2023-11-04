defmodule Bank.Ach.PosAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :pos_addenda)
    |> field!(:record_type_code, :M, "7", 1)
    |> field!(:addenda_type_code, :M, "02", 2)
    |> field!(:reference_information_1, :O, :alphameric, 7)
    |> field!(:reference_information_2, :O, :alphameric, 3)
    |> field!(:terminal_identication_code, :R, :alphameric, 6)
    |> field!(:transaction_serial_number, :R, :alphameric, 6)
    |> field!(:transaction_date, :R, :mmdd, 4)
    |> field!(:authorization_code, :O, :alphameric, 6)
    |> field!(:terminal_location, :R, :alphameric, 27)
    |> field!(:terminal_city, :R, :alphameric, 15)
    |> field!(:terminal_state, :R, :alphameric, 2)
    |> field!(:trace_number, :M, :numeric, 15)
    |> Map.get(:record)
  end
end
