defmodule Bank.Ach.FileControl do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :file_control)
    |> field!(:record_type_code, 1, "9")
    |> field!(:batch_count, 6, :numeric)
    |> field!(:block_count, 6, :numeric)
    |> field!(:entry_addenda_count, 8, :numeric)
    |> field!(:entry_hash, 10, :numeric)
    |> field!(:total_debit_amount, 12, :amount_in_cents)
    |> field!(:total_credit_amount, 12, :amount_in_cents)
    |> field!(:reserved, 39, :blank)
    |> Map.get(:record)
  end
end
