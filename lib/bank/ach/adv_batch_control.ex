defmodule Bank.Ach.AdvBatchControl do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :adv_batch_control)
    |> field!(:record_type_code, 1, "8")
    |> field!(:service_class_code, 3, :numeric)
    |> field!(:entry_addenda_count, 6, :numeric)
    |> field!(:entry_hash, 10, :numeric)
    |> field!(:total_debit_amount, 20, :amount_in_cents)
    |> field!(:total_credit_amount, 20, :amount_in_cents)
    |> field!(:ach_operator_data, 19, :alphameric)
    |> field!(:originating_dfi_identification, 8, :routing_number)
    |> field!(:batch_number, 7, :numeric)
    |> Map.get(:record)
  end
end
