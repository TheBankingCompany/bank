defmodule Bank.Ach.PpdEntry do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :ppd_entry)
    |> field!(:record_type_code, :M, "6", 1)
    |> field!(:transaction_code, :M, :numeric, 2)
    |> field!(:receiving_dfi_identification, :M, :routing_number, 8)
    |> field!(:check_digit, :M, :numeric, 1)
    |> field!(:dfi_account_number, :R, :alphameric, 17)
    |> field!(:amount, :M, :amount_in_cents, 10)
    |> field!(:individual_identification_number, :O, :alphameric, 15)
    |> field!(:individual_name, :R, :alphameric, 22)
    |> field!(:discretionary_data, :O, :alphameric, 2)
    |> field!(:addenda_record_indicator, :M, :numeric, 1)
    |> field!(:trace_number, :M, :numeric, 15)
    |> Map.get(:record)
  end
end
