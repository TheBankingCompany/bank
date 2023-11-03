defmodule Bank.Ach.AdvFileControl do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :adv_file_control)
    |> field!(:record_type_code, :M, "9", 1)
    |> field!(:batch_count, :M, :numeric, 6)
    |> field!(:block_count, :M, :numeric, 6)
    |> field!(:entry_addenda_count, :M, :numeric, 8)
    |> field!(:entry_hash, :M, :numeric, 10)
    |> field!(:total_debit_amount, :M, :amount_in_cents, 20)
    |> field!(:total_credit_amount, :M, :amount_in_cents, 20)
    |> field!(:reserved, :NA, :blank, 23)
    |> Map.get(:record)
  end
end
