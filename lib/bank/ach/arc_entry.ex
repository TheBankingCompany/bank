defmodule Bank.Ach.ArcEntry do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :arc_entry)
    |> field!(:record_type_code, 1, "6")
    |> field!(:transaction_code, 2, :numeric)
    |> field!(:receiving_dfi_identification, 8, :routing_number)
    |> field!(:check_digit, 1, :numeric)
    |> field!(:dfi_account_number, 17, :alphameric)
    |> field!(:amount, 10, :amount_in_cents)
    |> field!(:check_serial_number, 15, :alphameric)
    |> field!(:receiver_name, 22, :alphameric)
    |> field!(:discretionary_data, 2, :alphameric)
    |> field!(:addenda_record_indicator, 1, :numeric)
    |> field!(:trace_number, 15, :numeric)
    |> Map.get(:record)
  end
end
