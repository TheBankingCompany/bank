defmodule Bank.Ach.FileParser.AdvFileControl do
  use Bank.Ach.FileParser.LineParser

  @impl Bank.Ach.FileParser.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :adv_file_control)
    |> field!(:record_type_code, 1, "9")
    |> field!(:batch_count, 6, :numeric)
    |> field!(:block_count, 6, :numeric)
    |> field!(:entry_addenda_count, 8, :numeric)
    |> field!(:entry_hash, 10, :numeric)
    |> field!(:total_debit_amount, 20, :amount_in_cents)
    |> field!(:total_credit_amount, 20, :amount_in_cents)
    |> field!(:reserved, 23, :blank)
    |> Map.get(:record)
  end
end
