defmodule Bank.Ach.FileParser.FileControl do
  use Bank.Ach.FileParser.LineParser

  @impl Bank.Ach.FileParser.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :file_control)
    |> field!(:record_type_code, 1, :string)
    |> field!(:batch_count, 6, :integer)
    |> field!(:block_count, 6, :integer)
    |> field!(:entry_addenda_count, 8, :integer)
    |> field!(:entry_hash, 10, :integer)
    |> field!(:total_debit_amount, 12, :integer)
    |> field!(:total_credit_amount, 12, :integer)
    |> field!(:reserved, 39, :string)
    |> Map.get(:record)
  end
end
