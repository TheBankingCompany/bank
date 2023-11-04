defmodule Bank.Ach.MteAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :mte_addenda)
    |> field!(:record_type_code, :M, "7", 1)
    |> field!(:addenda_type_code, :M, "02", 2)
    |> field!(:transaction_description, :R, :alphameric, 7)
    |> field!(:network_identification_code, :O, :alphameric, 3)
    |> field!(:terminal_identification_code, :R, :alphameric, 6)
    |> field!(:transaction_serial_number, :R, :alphameric, 6)
    |> field!(:transaction_date, :R, :mmdd, 4)
    |> field!(:transaction_time, :R, :hhmmss, 6)
    |> field!(:terminal_location, :R, :alphameric, 27)
    |> field!(:terminal_city, :R, :alphameric, 15)
    |> field!(:terminal_state, :R, :alphameric, 2)
    |> field!(:trace_number, :M, :numeric, 15)
    |> Map.get(:record)
  end
end
