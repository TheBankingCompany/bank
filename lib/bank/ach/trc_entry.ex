defmodule Bank.Ach.TrcEntry do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :trc_entry)
    |> field!(:record_type_code, :M, "6", 1)
    |> field!(:transaction_code, :M, :numeric, 2)
    |> field!(:receiving_dfi_identification, :M, :routing_number, 8)
    |> field!(:check_digit, :M, :numeric, 1)
    |> field!(:dfi_account_number, :R, :alphameric, 17)
    |> field!(:amount, :M, :amount_in_cents, 10)
    |> field!(:check_serial_number, :O, :alphameric, 15)
    |> field!(:process_control_field, :R, :alphameric, 6)
    |> field!(:item_research_number, :R, :alphameric, 16)
    |> field!(:item_type_indicator, :O, :alphameric, 2)
    |> field!(:addenda_record_indicator, :M, :numeric, 1)
    |> field!(:trace_number, :M, :numeric, 15)
    |> Map.get(:record)
  end
end
