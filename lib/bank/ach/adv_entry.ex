defmodule Bank.Ach.AdvEntry do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :adv_entry)
    |> field!(:record_type_code, :M, "6", 1)
    |> field!(:transaction_code, :M, :numeric, 2)
    |> field!(:receiving_dfi_identification, :M, :routing_number, 8)
    |> field!(:check_digit, :M, :numeric, 1)
    |> field!(:dfi_account_number, :R, :alphameric, 15)
    |> field!(:amount, :M, :amount_in_cents, 12)
    |> field!(:advice_routing_number, :M, :numeric, 9)
    |> field!(:file_identification, :O, :alphameric, 5)
    |> field!(:ach_operator_data, :O, :alphameric, 1)
    |> field!(:individual_name, :R, :alphameric, 22)
    |> field!(:discretionary_data, :O, :alphameric, 2)
    |> field!(:addenda_record_indicator, :M, :numeric, 1)
    |> field!(:ach_operator_routing_number, :M, :routing_number, 8)
    |> field!(:advice_creation_date, :M, :numeric, 3)
    |> field!(:batch_sequence_number, :M, :numeric, 4)
    |> Map.get(:record)
  end
end
