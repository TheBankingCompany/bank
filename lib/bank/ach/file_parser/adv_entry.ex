defmodule Bank.Ach.FileParser.AdvEntry do
  use Bank.Ach.FileParser.LineParser

  @impl Bank.Ach.FileParser.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :adv_entry)
    |> field!(:record_type_code, 1, "6")
    |> field!(:transaction_code, 2, :numeric)
    |> field!(:receiving_dfi_identification, 8, :routing_number)
    |> field!(:check_digit, 1, :numeric)
    |> field!(:dfi_account_number, 15, :alphameric)
    |> field!(:amount, 12, :amount_in_cents)
    |> field!(:advice_routing_number, 9, :numeric)
    |> field!(:file_identification, 5, :alphameric)
    |> field!(:ach_operator_data, 1, :alphameric)
    |> field!(:individual_name, 22, :alphameric)
    |> field!(:discretionary_data, 2, :alphameric)
    |> field!(:addenda_record_indicator, 1, :numeric)
    |> field!(:ach_operator_routing_number, 8, :routing_number)
    |> field!(:advice_creation_date, 3, :numeric)
    |> field!(:batch_sequence_number, 4, :numeric)
    |> Map.get(:record)
  end
end
