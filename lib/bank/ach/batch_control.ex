defmodule Bank.Ach.BatchControl do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :batch_control)
    |> field!(:record_type_code, :M, "8", 1)
    |> field!(:service_class_code, :M, :numeric, 3)
    |> field!(:entry_addenda_count, :M, :numeric, 6)
    |> field!(:entry_hash, :M, :numeric, 10)
    |> field!(:total_debit_amount, :M, :amount_in_cents, 12)
    |> field!(:total_credit_amount, :M, :amount_in_cents, 12)
    |> field!(:company_identification, :R, :alphameric, 10)
    |> field!(:message_authentication_code, :O, :alphameric, 19)
    |> field!(:reserved, :NA, :blank, 6)
    |> field!(:originating_dfi_identification, :M, :routing_number, 8)
    |> field!(:batch_number, :M, :numeric, 7)
    |> Map.get(:record)
  end
end
